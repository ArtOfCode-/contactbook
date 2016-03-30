class ContactsController < ApplicationController
  before_filter :authenticate_user
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, except: [:index, :new, :create, :show_all, :encrypt, :do_encrypt]
  before_action :decrypt_set_contact, only: [:show, :edit]
  before_action :verify_admin, only: [:show_all]

  # GET /contacts/all
  def show_all
    @contacts = Contact.joins("inner join users on contacts.created_by = users.id")
      .select("contacts.created_by, contacts.id, contacts.title, contacts.first, contacts.last, contacts.city, contacts.phone, contacts.email, users.username")
    # Don't bother decrypting these contacts; administrators won't be able to decrypt everything because DEKs are based
    # on passwords. Only some contacts (their own) would show in plain text.
  end

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.select("id, title, first, last, city, phone, email").where("created_by" => @current_user.id)
    @contacts = decrypt_contacts(@contacts)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.created_by = @current_user.id

    @contact = encrypt_contacts(@contact)

    respond_to do |format|
      if @contact.save
        format.html {
          flash[:notice] = "Contact was successfully created."
          flash[:color] = "valid"
          redirect_to action: "index"
        }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    # Because we're encrypting, just updating the old contact leaves a point of vulnerability at which the plaintext
    # details are in the database. To avoid that, destroy the old record and replace it with a new one, which is
    # encrypted before it ever hits the database.
    old_contact = Contact.find(params[:id])
    old_contact.destroy

    @contact = Contact.new(contact_params)
    @contact.id = params[:id]
    @contact.created_by = @current_user.id

    @contact = encrypt_contacts(@contact)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def encrypt
  end

  def do_encrypt
    @contacts = Contact.where(:created_by => @current_user.id, :is_encrypted => false)
    puts "Found #{@contacts.count} contacts by user #{@current_user.id} with :is_encrypted => false"
    @contacts.each do |contact|
      contact = encrypt_contacts(contact)
      contact.is_encrypted = true
      contact.save
    end
    flash[:notice] = "Your contacts were successfully encrypted."
    flash[:color] = "valid"
    render :encrypt
  end


  # Methods that are specific to contacts operations.
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def decrypt_set_contact
      @contact = decrypt_contacts(@contact)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first, :last, :title, :city, :phone, :email)
    end

    def check_ownership
      if @contact.created_by != @current_user.id
        respond_to do |format|
          format.html { render(:file => File.join(Rails.root, 'public/403'), :formats => [:html], :status => 403) }
          format.json { head :forbidden }
        end
      end
    end
end
