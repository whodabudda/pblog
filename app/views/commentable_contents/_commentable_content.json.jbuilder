json.extract! commentable_content, :id, :created_at, :updated_at
json.url commentable_content_url(commentable_content, format: :json)