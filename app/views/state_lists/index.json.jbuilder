json.array!(@state_lists) do |state_list|
  json.extract! state_list, :id
  json.url state_list_url(state_list, format: :json)
end
