module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def icon_class_by(provider)
    case provider
    when 'vkontakte' then 'vk'
    when 'sms' then 'comments-o'
    else
      provider
    end
  end
end
