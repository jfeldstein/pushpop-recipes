require 'pushpop'

job 'Pingpong check response report' do

  every 24.hours

  keen 'load_response_times' do
    event_collection  'checks'
    analysis_type     'average'
    target_property   'request.duration'
    timeframe         'last_24_hours'
    group_by          'check.name'
  end

  sendgrid 'send_email' do |response, step_responses|
    to 'josh+pushpop@keen.io'
    from 'josh+pushpop@keen.io'
    subject 'Pingpong Daily Response Time Report'
    body 'response_time_report.html.erb', response, step_responses
    preview ENV['PREVIEW']
  end

end
