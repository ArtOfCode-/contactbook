class ExportsController < ApplicationController
  before_filter :set_contact, :only => [:vcard]
  before_filter :set_contacts, :only => [:json, :xml]
  before_filter :authenticate_user
  before_filter :verify_ownership, :only => [:vcard]

  def json
    render :json => @contacts
  end

  def xml
    render :xml => @contacts
  end

  def vcard
    vcard = VCardigan.create
    vcard.name @contact.last, @contact.first
    vcard.fullname "#{@contact.title} #{@contact.first} #{@contact.last}"
    vcard.email @contact.email
    vcard.tel @contact.phone, :type => 'home'
    vcard.city @contact.city

    response.headers['Content-Type'] = 'text/vcard'
    render :text => vcard.to_s
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
      @contact = decrypt_contacts(@contact)
    end

    def set_contacts
      @contacts = Contact.select("id, title, first, last, city, phone, email").where("created_by" => @current_user.id)
      @contacts = decrypt_contacts(@contacts)
    end

    def verify_ownership
      if @contact.created_by != @current_user.id && !@current_user.is_admin
        render(:file => File.join(Rails.root, 'public/403'), :formats => [:html], :status => 403)
        return
      end
    end
end
