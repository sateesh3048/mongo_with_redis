class CategoriesController < ApplicationController
  before_action :set_locale

  def index
    # puts "welcome afdkjdklldfklkdaklfds"
    @categories = Category.fetch_categories
    # puts "@categories>>>>@categories>>>@categories"
    # puts @categories.inspect
    # puts "dsfajdldsfaldfsllkfdskl"

    puts "Subdomains>>>>Subdomains>>>>Subdomains>>>>Subdomains>>>>"
    puts request.subdomains.first.inspect
    puts "**"*20
  end

  def set_locale
    puts "Current Localed Name is "
    puts params[:locale].inspect
    puts "******************************************"
    I18n.locale = params[:locale] || "en"
  end

end
