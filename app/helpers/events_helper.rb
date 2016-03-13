module EventsHelper
  def humanize_event(event)
    case event
    when 'join'
      t('events.join')
    when 'post'
      t('events.post')
    when 'auth'
      t('events.auth')
    when 'member'
      t('events.member')
    else
      t('events.unknown')
    end
  end
end
