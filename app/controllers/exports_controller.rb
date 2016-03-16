class ExportsController < ApplicationController
  before_filter :authenticate_user

  def json
    contacts = Contact.select("title, first, last, city, phone, email").where("created_by" => @current_user.id)
    render :json => contacts
  end

  def xml
    contacts = Contact.select("title, first, last, city, phone, email").where("created_by" => @current_user.id)
    render :xml => contacts
  end
end
