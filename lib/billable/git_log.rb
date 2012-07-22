class Billable::GitLog
  DAYS = ['mon', 'tue', 'wed', 'thu', 'fri']
  def initialize(from, to, author)
    @from, @to, @author = from, to, author
    @logs = parse log_entries
  end

  def self.fields
    [:author, :date, :desc]
  end

  def log_entries
    p "Getting Git logs from #{@from} to #{@to}"
    `git log --since=#{@from} --until=#{@to} --grep=#{@author} --pretty=format:"%an | %aD | %s"`
  end

  def activity(day_num)
    DAYS.map do |day|
      @logs.select {|log| log[:date] =~ /#{day}/i}.map {|log| log[:desc]}.join(",")
    end[day_num]
  end

  def self.last_monday
    1.week.ago.beginning_of_week.strftime('%-m/%-d/%Y')
  end

  def self.last_friday
    (1.week.ago.beginning_of_week + 4.days).strftime('%-m/%-d/%Y')
  end

  private

  def parse(log_entries)
    log_entries.split("\n").map do |line|
      Hash[::Billable::GitLog.fields.zip(line.split("|").map(&:strip))]
    end
  end
end