defmodule CadenBartonShowcase.OpenAIClientTest do
  use ExUnit.Case, async: true

  alias CadenBartonShowcase.OpenAIClient

  test "build_ai_conductor_prompt includes persona label and idea text" do
    persona = "developer"
    idea = "I want to ship a LiveView admin dashboard."

    prompt = OpenAIClient.build_ai_conductor_prompt(persona, idea)

    assert prompt =~ "Developer"
    assert prompt =~ idea
    assert prompt =~ "AI Conductor behind Caden Barton’s portfolio website"
  end

  test "ai_conductor_advice returns missing api key when unset or blank" do
    original = System.get_env("OPENAI_API_KEY")

    on_exit(fn ->
      case original do
        nil -> System.delete_env("OPENAI_API_KEY")
        _ -> System.put_env("OPENAI_API_KEY", original)
      end
    end)

    System.delete_env("OPENAI_API_KEY")
    assert {:error, :missing_api_key} = OpenAIClient.ai_conductor_advice("developer", "Test")

    System.put_env("OPENAI_API_KEY", "")
    assert {:error, :missing_api_key} = OpenAIClient.ai_conductor_advice("developer", "Test")
  end

  test "extract_text handles output_text at top level" do
    body = %{"output_text" => "answer"}
    assert {:ok, "answer"} = OpenAIClient.extract_text(body)
  end

  test "extract_text handles output content array with output_text type" do
    body = %{
      "output" => [
        %{
          "content" => [
            %{"type" => "output_text", "text" => "structured answer"}
          ]
        }
      ]
    }

    assert {:ok, "structured answer"} = OpenAIClient.extract_text(body)
  end

  test "extract_text handles top-level text field" do
    assert {:ok, "plain"} = OpenAIClient.extract_text(%{"text" => "plain"})
  end

  test "extract_text returns error when no text output found" do
    assert {:error, :no_text_output} =
             OpenAIClient.extract_text(%{"output" => [%{"content" => [%{"type" => "other"}]}]})
  end
end
