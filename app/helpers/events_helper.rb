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
    when 'sms_ident'
      t('events.identification')
    when 'sms_ident_adv'
      t('events.ident_adv')
    else
      t('events.unknown')
    end
  end
end
