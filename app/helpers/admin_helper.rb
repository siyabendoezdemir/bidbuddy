module AdminHelper
  def render_auction_status(status)
    case status
    when "pending"
      content_tag(:span, "Pending", class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800")
    when "active"
      content_tag(:span, "Active", class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800")
    when "ended"
      content_tag(:span, "Ended", class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800")
    else
      content_tag(:span, status.capitalize, class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800")
    end
  end

  def render_account_role(role)
    case role
    when "admin"
      content_tag(:span, "Admin", class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-purple-100 text-purple-800")
    when "seller"
      content_tag(:span, "Seller", class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800")
    when "buyer"
      content_tag(:span, "Buyer", class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800")
    else
      content_tag(:span, role.capitalize, class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800")
    end
  end
end
