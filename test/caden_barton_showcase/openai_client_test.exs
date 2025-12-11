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

    System.delete_env("OPENAI_API_KEY")
    assert {:error, :missing_api_key} = OpenAIClient.ai_conductor_advice("developer", "Test")

    System.put_env("OPENAI_API_KEY", "")
    assert {:error, :missing_api_key} = OpenAIClient.ai_conductor_advice("developer", "Test")

    if original, do: System.put_env("OPENAI_API_KEY", original), else: System.delete_env("OPENAI_API_KEY")
  end
end
