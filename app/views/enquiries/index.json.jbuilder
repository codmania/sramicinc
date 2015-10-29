json.array!(@enquiries) do |enquiry|
  json.extract! enquiry, :id
  json.url enquiry_url(enquiry, format: :json)
end
