class ExamplesController < ApplicationController
  
  layout "admin"
  
  before_filter :login_required, :except => [:show, :index]
  
  # GET /examples
  # GET /examples.xml
  def index
    @title = "Examples"
    @examples = Example.find(:all)
    @sections = ExampleSection.find(:all, :order => "position")
    respond_to do |format|
      format.html { render :layout => "page" }
      format.xml  { render :xml => @examples }
    end
  end
  
  def reorder
    @examples = Example.find(:all)
  end

  # GET /examples/1
  # GET /examples/1.xml
  def show
    @example = Example.find(params[:id])
    layout = (logged_in? && current_user.admin?) ? "admin" : "page"
    @title = @example.title if layout == "page"
    
    respond_to do |format|
      format.html { render :layout => layout }
      format.xml  { render :xml => @example }
    end
  end

  # GET /examples/new
  # GET /examples/new.xml
  def new
    @example = Example.new
    @sections = ExampleSection.find(:all)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @example }
    end
  end

  # GET /examples/1/edit
  def edit
    @example = Example.find(params[:id])
    @sections = ExampleSection.find(:all)
  end

  # POST /examples
  # POST /examples.xml
  def create
    @example = Example.new(params[:example])

    respond_to do |format|
      if @example.save
        flash[:notice] = 'Example was successfully created.'
        format.html { redirect_to(@example) }
        format.xml  { render :xml => @example, :status => :created, :location => @example }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @example.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examples/1
  # PUT /examples/1.xml
  def update
    @example = Example.find(params[:id])
    
    respond_to do |format|
      if @example.update_attributes(params[:example])
        flash[:notice] = 'Example was successfully updated.'
        format.html { redirect_to(@example) }
        format.xml  { head :ok }
      else
        format.html do
          @sections = ExampleSection.find(:all)
          render :action => "edit"
        end
        format.xml  { render :xml => @example.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examples/1
  # DELETE /examples/1.xml
  def destroy
    @example = Example.find(params[:id])
    @example.destroy

    respond_to do |format|
      format.html { redirect_to(examples_url) }
      format.xml  { head :ok }
    end
  end
  
end
