---
name: kickoff
description: Start a new prototype by asking the kickoff questions and writing the brief. Use when docs/brief.md is not filled in, or when someone says they want to start something new.
---

# Kick off a new prototype

A prototype without a brief tends to become a generic page. Before building anything, have a short conversation and write down the answers.

1. If `.buildkit` says `profile=unset`, first ask: "Is this just for you, a tool for the agency, or for a client?" Set the profile as described under Choosing the profile in `.core/AGENTS.md`. Never guess it from the request.
2. **Match the questions to the size of the ask.** Most asks are small. If the person asks for something small or says it's a test, like a hello world page or a page with one message, ask no questions at all: write the brief yourself from what they said, tell them in one sentence what you understood, and start building. Only ask a question whose answer would actually change the first draft. Never ask about data, feedback or feelings for something that obviously has none of that. The full list below is for a real prototype that someone else will look at, and even then, ask at most three or four of them.
3. When questions are needed, say in one sentence that you'll ask a couple first, so the first draft is about the right thing. Skip anything the person has already told you, for example what it is and who it's for when the project was just created. Ask the rest **one at a time**. Wait for each answer. Keep your own words short and friendly, and offer an example answer if the person seems unsure.
4. If an answer is vague, ask one follow-up at most, then move on. If the person answers several questions at once, or pastes a whole brief, accept it and only ask about what's missing.
5. Write `docs/brief.md` with one short section per question, in the person's own words, and write "not discussed" for anything you didn't ask. Remove the line that says the brief is not filled in.
6. For a real prototype, read the brief back as three bullet points and ask if it's right. For a small one, skip this.
7. Then start building, using the `build-prototype` skill.

## The questions

1. **Who is it for?** Who will use it, and who will look at the prototype?
2. **The moment.** When does someone need this? What are they trying to get done?
3. **What should they see or do?** The two or three things the prototype must show.
4. **The one thing it must get right.** If only one thing works, what should it be?
5. **How should it feel?** Three words, or a reference you like.
6. **Out of scope.** What should it clearly not try to do yet?
7. **Data.** Does it touch any real personal or client data? If yes, we use fake sample data and note it here.
8. **Feedback.** Who gives feedback, and what kind of feedback do you want?

## Internal tools

If `.buildkit` says `profile=internal`, also ask these, one at a time, and add them to the brief:

1. **Who uses it.** Which people or teams in the agency, and how often?
2. **What it replaces.** What do they do today instead?
3. **Owner.** Who looks after it once it works?

The live link is public, so an internal tool still uses fake data. If it needs real agency data, say so in the brief: it then needs private hosting first.

## Client projects

If `.buildkit` says `profile=client`, also ask these, one at a time, and add them to the brief:

1. **Client and delivery.** Who is the client, and what exactly do we deliver?
2. **Hosting.** Where will it run, and who deploys it?
3. **Data.** Will it handle personal data? If yes, who is responsible for it, and is there a data processing agreement?
4. **Accessibility.** Which level do we commit to, for example WCAG 2.2 AA?
5. **Browsers and devices.** What must it support?
6. **Approval.** Who reviews pull requests, and who signs off for the client?

