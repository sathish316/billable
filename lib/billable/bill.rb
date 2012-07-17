class Billable::Bill
  def initialize(profile_name, settings)
    @profile_name = profile_name
    @settings = settings
    @agent = Mechanize.new
    @page = @agent.get(@settings[:url])
  end

  def submit(git_log)
    @git_log = git_log
    login if login_required?
    @timesheet = @page.forms[0]
    fill_timesheet
    save_timesheet
  end

  private

  def login
    login_form = @page.forms[0]
    login_form.send("#{profile['username_field']}=", @settings[:username])
    login_form.send("#{profile['password_field']}=", @settings[:password])
    @page = @agent.submit(login_form, login_form.button_with(:name => 'submit'))
    @page = @agent.get(@settings[:url])
  end

  def fill_timesheet
    @timesheet.field_with(:id => profile['activity_end_date']).value = Date.strptime(@settings[:to], "%m/%d/%Y").end_of_week.strftime("%d %b %Y")
    @timesheet.radiobuttons_with(:id => profile["activity_no_expense"])[0].check
    0.upto(4) do |i|
      @timesheet.field_with(:id => profile['activity_country'].gsub('NNN',i.to_s)).value = @settings[:country]
      @timesheet.field_with(:id => profile['activity_code'].gsub('NNN',i.to_s)).value = @settings[:code]
      @timesheet.radiobutton_with(:id => profile['activity_billable'].gsub('NNN',i.to_s)).check
      task = @git_log.activity(i)
      p "Day #{i}: #{task}"
      @timesheet.field_with(:id => profile['activity_description'].gsub('NNN',i.to_s)).value = task
      @timesheet.field_with(:id => profile["activity_hours_#{i}"]).value = @settings[:hours]
    end
  end

  def save_timesheet
    save_button = @timesheet.buttons_with(:name => profile['save_button_name'])[0]
    @page = @agent.submit(@timesheet, save_button)
    errors = @page.search(profile['errors_selector']).first
    p "ERROR: #{errors.content}" if errors
  end

  def profile
    @settings[:profiles][@profile_name]
  end

  def login_required?
    @settings[:login]
  end
end