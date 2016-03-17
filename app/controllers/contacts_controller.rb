class ContactsController < ApplicationController
  before_filter :authenticate_user
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, except: [:index, :new, :create]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.select("id, title, first, last, city, phone, email").where("created_by" => @current_user.id)
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
    respond_to do |format|
      if @contact.update(contact_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first, :last, :title, :city, :phone, :email)
    end

    def check_ownership
      puts "Checking ownership of contact..."
      if @contact.created_by != @current_user.id && !@current_user.is_admin
        respond_to do |format|
          format.html { render(:file => File.join(Rails.root, 'public/403'), :formats => [:html], :status => 403) }
          format.json { head :forbidden }
        end
      end
    end
end
