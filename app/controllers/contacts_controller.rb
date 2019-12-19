# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = User.create.id

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # POST /mass_create
  def mass_create
    contact_attrs = params[:contact_attrs] || GenerateContacts.new.call

    contacts = []

    user_id = User.create.id
    time = Time.now

    contact_attrs.each do |attrs|
      # validate presence of name and email
      next unless attrs[:name].present? && attrs[:email].present?

      contact = Contact.new(attrs)
      contacts << {id: contact.id, name: contact.name, email: contact.email, user_id: user_id, created_at: time, updated_at: time}
    end

    Contact.insert_all contacts

    render json: contacts, status: :created
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, contact_addresses_attributes: [:street, :city, :number ])
    end
end
