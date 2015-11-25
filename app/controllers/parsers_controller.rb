require 'nokogiri'
require 'open-uri'
require 'uri'

class ParsersController < ApplicationController
  before_action :set_parser, only: [:show, :edit, :update, :destroy]

  # GET /parsers
  # GET /parsers.json
  def index
    pageUrl = 'http://www.lazada.vn/dong-ho/'
		uri = URI(pageUrl)
		case uri.host
		when "www.lazada.vn"
			#@parsers = Array.new
			@parsers = lazada_dongho(pageUrl)
			#puts "@parsers"
		else
			@content = unknow(pageUrl)
		end
		@url = pageUrl
  end

  # GET /parsers/1
  # GET /parsers/1.json
  def show
  end

  # GET /parsers/new
  def new
    @parser = Parser.new
  end

  # GET /parsers/1/edit
  def edit
  end

  # POST /parsers
  # POST /parsers.json
  def create
    @parser = Parser.new(parser_params)

    respond_to do |format|
      if @parser.save
        format.html { redirect_to @parser, notice: 'Parser was successfully created.' }
        format.json { render :show, status: :created, location: @parser }
      else
        format.html { render :new }
        format.json { render json: @parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parsers/1
  # PATCH/PUT /parsers/1.json
  def update
    respond_to do |format|
      if @parser.update(parser_params)
        format.html { redirect_to @parser, notice: 'Parser was successfully updated.' }
        format.json { render :show, status: :ok, location: @parser }
      else
        format.html { render :edit }
        format.json { render json: @parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parsers/1
  # DELETE /parsers/1.json
  def destroy
    @parser.destroy
    respond_to do |format|
      format.html { redirect_to parsers_url, notice: 'Parser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parser
      @parser = Parser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parser_params
      params[:parser]
    end
		
		def hoclamgiau
		end
		
		def lazada_dongho(pageUrl)
			doc = Nokogiri::HTML(open(pageUrl))
			#bodies = Array.new
			#bodies.each do |body|
		  	body = doc.search('ul.mobile-product-list')
		  	body.search('div.container li') do |f|
		  	  body['class'] = "li_prod"
		  	end
		  	body.inner_html
			#end
		  
			body.xpath('//@style').remove
			#body.xpath('//@class').remove
			body.xpath('//@id').remove
			return body
		end
		
		def unknow(pageUrl)
			doc = Nokogiri::HTML(open(pageUrl))
			body = doc.css('body')
			body.xpath('//@style').remove
			body.xpath('//@class').remove
			body.xpath('//@id').remove
			body.inner_html # apply the changes
		end
end
