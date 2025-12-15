defmodule CadenBartonShowcase.OpenAIClient do
  @moduledoc false

  require Logger

  @responses_url "https://api.openai.com/v1/responses"
  @openai_model "gpt-5-mini"

  @spec ai_conductor_advice(String.t(), String.t()) :: {:ok, String.t()} | {:error, term()}
  def ai_conductor_advice(persona, idea_text) do
    case System.get_env("OPENAI_API_KEY") do
      key when is_binary(key) ->
        trimmed_key = String.trim(key)

        if trimmed_key == "" do
          {:error, :missing_api_key}
        else
          prompt = build_ai_conductor_prompt(persona, idea_text)

          body = %{
            "model" => @openai_model,
            "input" => prompt
          }

          with {:ok, %Req.Response{status: status} = response} when status in 200..299 <-
                 Req.request(
                   url: @responses_url,
                   method: :post,
                   json: body,
                   headers: headers(trimmed_key)
                 ),
               {:ok, text} <- extract_text(response.body) do
            {:ok, text}
          else
            {:ok, %Req.Response{status: status} = resp} ->
              Logger.debug(fn ->
                "OpenAI Responses non-success status: #{inspect(status)}, body: #{inspect(resp.body)}"
              end)

              {:error, {:http_error, status}}

            {:error, reason} ->
              Logger.debug(fn -> "OpenAI Responses request failed: #{inspect(reason)}" end)
              {:error, reason}

            other ->
              Logger.debug(fn -> "OpenAI Responses unexpected result: #{inspect(other)}" end)
              {:error, :unexpected_openai_response}
          end
        end

      _ ->
        {:error, :missing_api_key}
    end
  end

  @doc false
  @spec build_ai_conductor_prompt(String.t(), String.t()) :: String.t()
  def build_ai_conductor_prompt(persona, idea_text) do
    persona_label =
      case persona do
        "hiring_manager" -> "Hiring manager"
        "developer" -> "Developer"
        "just_curious" -> "Just curious visitor"
        _ -> "Visitor"
      end

    """
    You are the AI Conductor behind Caden Barton’s portfolio website.
    The visitor persona: #{persona_label}.
    Their idea or situation: #{idea_text}.

    Please respond in three short sections with Markdown headings, under 250 words total:
    1) What you’re trying to do
    2) How I’d orchestrate AI for you
    3) Where this matches my workflow
    """
  end

  defp headers(api_key) do
    [
      {"content-type", "application/json"},
      {"authorization", "Bearer " <> api_key}
    ]
  end

  @doc false
  def extract_text(%{"output_text" => text}) when is_binary(text), do: {:ok, text}

  def extract_text(%{"text" => text}) when is_binary(text), do: {:ok, text}

  def extract_text(%{"output" => output}) do
    output
    |> List.wrap()
    |> Enum.find_value(fn item ->
      item
      |> Map.get("content")
      |> List.wrap()
      |> Enum.find_value(fn
        %{"text" => text, "type" => type} when is_binary(text) and (is_nil(type) or type == "output_text") ->
          text

        %{"text" => text} when is_binary(text) ->
          text

        _ ->
          nil
      end)
    end)
    |> case do
      text when is_binary(text) -> {:ok, text}
      _ -> {:error, :no_text_output}
    end
  end

  def extract_text(_), do: {:error, :no_text_output}
end
