class ExportsController < ApplicationController
  before_filter :set_contact, :only => [:vcard]
  before_filter :authenticate_user
  before_filter :verify_ownership, :only => [:vcard]

  def json
    contacts = Contact.select("id, title, first, last, city, phone, email").where("created_by" => @current_user.id)
    render :json => contacts
  end

  def xml
    contacts = Contact.select("id, title, first, last, city, phone, email").where("created_by" => @current_user.id)
    render :xml => contacts
  end

  def vcard
    vcard = VCardigan.create
    vcard.name @contact.last, @contact.first
    vcard.fullname "#{@contact.first} #{@contact.last}"
    vcard.email @contact.email
    vcard.phone @contact.phone
    vcard.title @contact.title
    vcard.city @contact.city

    response.headers['Content-Type'] = 'text/vcard'
    render :text => vcard.to_s
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def verify_ownership
      if @contact.created_by != @current_user.id && !@current_user.is_admin
        render(:file => File.join(Rails.root, 'public/403'), :formats => [:html], :status => 403)
        return
      end
    end
end
