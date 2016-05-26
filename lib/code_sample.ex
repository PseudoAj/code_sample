#Modulde to create,get, update and delete the comments for the file.
defmodule CodeSample do
  #Function 1: create comments
  #This function would take the comment as parameter and
  #add to a particular file_id
  #Request:
  #curl https://api.box.com/2.0/comments \
  #-H "Authorization: Bearer ACCESS_TOKEN" \
  #-d '{"item": {"type": "file", "id": "FILE_ID"}, "message": "YOUR_MESSAGE"}' \
  #-X POST
  #Have used upload file as reference
  @spec create_comments!(String.t, String.t,String.t) :: integer
  def create_comments!(file_id,token,msg) do
    case HTTPoison.post! "https://api.box.com/2.0/comments", %{Authorization: "Bearer #{token}"}, Poison.encode!(%{item: %{type: "file", id: file_id}, message: msg}), do
      %{status_code: 201, body: body} ->
        body
        |> Poison.decode!
      %{status_code: code, body: body} ->
        raise "Failed to add comments.  Received #{code}: #{body}"
    end
  end

  #Function 2: get comments
  #This function would take the comment as parameter and
  #get from particular file_id
  #Already provided
  @spec get_comments!(String.t, String.t) :: integer
  def get_comments!(file_id, token) do
    case HTTPoison.get! "https://api.box.com/2.0/files/#{file_id}/comments", %{Authorization: "Bearer #{token}"} do
      %{status_code: 200, body: body} ->
        body
        |> Poison.decode!
        |> Map.get("entries")`
      %{status_code: code, body: body} ->
        raise "Failed to get comments.  Received #{code}: #{body}"
    end
  end
end
