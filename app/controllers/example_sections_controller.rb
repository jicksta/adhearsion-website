class ExampleSectionsController < ApplicationController
  
  layout "admin"
  
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  # GET /example_sections
  # GET /example_sections.xml
  def index
    @example_sections = ExampleSection.find(:all, :order => "position")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @example_sections }
    end
  end

  # GET /example_sections/1
  # GET /example_sections/1.xml
  def show
    @example_section = ExampleSection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @example_section }
    end
  end

  # GET /example_sections/new
  # GET /example_sections/new.xml
  def new
    @example_section = ExampleSection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @example_section }
    end
  end

  # GET /example_sections/1/edit
  def edit
    @example_section = ExampleSection.find(params[:id])
  end

  # POST /example_sections
  # POST /example_sections.xml
  def create
    @example_section = ExampleSection.new(params[:example_section])

    respond_to do |format|
      if @example_section.save
        flash[:notice] = 'ExampleSection was successfully created.'
        format.html { redirect_to(@example_section) }
        format.xml  { render :xml => @example_section, :status => :created, :location => @example_section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @example_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /example_sections/1
  # PUT /example_sections/1.xml
  def update
    @example_section = ExampleSection.find(params[:id])

    respond_to do |format|
      if @example_section.update_attributes(params[:example_section])
        flash[:notice] = 'ExampleSection was successfully updated.'
        format.html { redirect_to(@example_section) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @example_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /example_sections/1
  # DELETE /example_sections/1.xml
  def destroy
    @example_section = ExampleSection.find(params[:id])
    @example_section.destroy

    respond_to do |format|
      format.html { redirect_to(example_sections_url) }
      format.xml  { head :ok }
    end
  end
  
end
