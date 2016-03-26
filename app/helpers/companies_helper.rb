module CompaniesHelper
  def company_status(company)
    if company.active?
      content_tag :span, '', class: 'active glyphicon glyphicon-ok-circle'
    else
      content_tag :span, '', class: 'hold glyphicon glyphicon-ban-circle'
    end
  end
end
