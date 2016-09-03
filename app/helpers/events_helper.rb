module EventsHelper
  def humanize_event(event)
    case event
    when 'join'
      t('events.join')
    when 'post'
      t('events.post')
    when 'auth'
      t('events.auth')
    when 'photo'
      t('events.photo')
    when 'member'
      t('events.member')
    when 'sms_ident'
      t('events.identification')
    when 'sms_ident_adv'
      t('events.ident_adv')
    when 'login'
      t('events.login')
    else
      t('events.unknown')
    end
  end
end
