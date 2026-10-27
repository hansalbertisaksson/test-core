// Renders kit.json, which the build writes on every deploy.
const el = (tag, attrs = {}, ...children) => {
  const node = document.createElement(tag);
  for (const [key, value] of Object.entries(attrs)) {
    if (key === "class") node.className = value;
    else node.setAttribute(key, value);
  }
  for (const child of children.flat()) node.append(child);
  return node;
};

// Just enough markdown for AGENTS.md: headings, lists, paragraphs, inline code and bold.
const inline = (text) => {
  const span = el("span");
  span.innerHTML = text
    .replace(/&/g, "&amp;").replace(/</g, "&lt;")
    .replace(/`([^`]+)`/g, "<code>$1</code>")
    .replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>");
  return span;
};

const renderMarkdown = (md) => {
  const out = [];
  let list = null;
  for (const line of md.split("\n").slice(1)) {
    const heading = line.match(/^#{2,3}\s+(.*)/);
    const bullet = line.match(/^\s*(?:-|\d+\.)\s+(.*)/);
    if (heading) { list = null; out.push(el("h3", {}, heading[1])); }
    else if (bullet) {
      if (!list) { list = el(/^\s*\d/.test(line) ? "ol" : "ul"); out.push(list); }
      list.append(el("li", {}, inline(bullet[1])));
    } else if (line.trim()) { list = null; out.push(el("p", {}, inline(line))); }
  }
  return out;
};

const resultBadge = (result) => {
  if (result === "ok") return el("span", { class: "badge badge-ok" }, "passed");
  if (result === "warn") return el("span", { class: "badge badge-result-warn" }, "warning");
  if (result === "block") return el("span", { class: "badge badge-result-block" }, "failed");
  return el("span", { class: "badge badge-none" }, "not run");
};

fetch("kit.json")
  .then((response) => response.json())
  .then((kit) => {
    const meta = document.getElementById("meta");
    const repoLink = kit.repository ? el("a", { href: `https://github.com/${kit.repository}` }, kit.repository) : "local build";
    [["Profile", kit.profile], ["Project", repoLink], ["Core version", kit.core_version], ["Built", kit.built_at]]
      .forEach(([label, value]) => meta.append(el("div", {}, el("dt", {}, label), el("dd", {}, value))));

    document.getElementById("skills").append(...kit.skills.map((skill) =>
      el("article", { class: "card skill" },
        el("h3", {}, skill.name),
        el("p", { class: "muted" }, skill.description),
        ...(skill.questions.length ? [el("details", { open: "" }, el("summary", {}, `The ${skill.questions.length} questions`), el("ol", {}, skill.questions.map((q) => el("li", {}, inline(q)))))] : []),
        el("details", {}, el("summary", {}, `${skill.steps.length} steps`), el("ol", {}, skill.steps.map((step) => el("li", {}, inline(step)))))
      )
    ));

    document.getElementById("checks").append(...kit.checks.map((check) =>
      el("div", { class: "check" },
        el("div", {}, el("div", { class: "check-name" }, check.check), el("div", { class: "check-desc" }, check.description)),
        el("span", { class: `badge badge-mode badge-${check.mode}` }, check.mode === "block" ? "blocks" : "warns"),
        resultBadge(check.result),
        ...(check.message ? [el("div", { class: "check-msg" }, check.message)] : [])
      )
    ));

    document.getElementById("profile-name").textContent = kit.profile;
    const names = Object.keys(kit.profiles);
    const allChecks = [...new Set(Object.values(kit.profiles).flat().map((row) => row.check))];
    const matrix = document.getElementById("matrix");
    matrix.append(el("thead", {}, el("tr", {}, el("th", {}, "Check"), names.map((name) => el("th", { class: name === kit.profile ? "current" : "" }, name)))));
    matrix.append(el("tbody", {}, allChecks.map((check) =>
      el("tr", {}, el("td", {}, check), names.map((name) => {
        const row = kit.profiles[name].find((r) => r.check === check);
        const cell = row ? el("span", { class: `badge badge-${row.mode}` }, row.mode === "block" ? "blocks" : "warns") : "–";
        return el("td", { class: name === kit.profile ? "current" : "" }, cell);
      }))
    )));

    document.getElementById("rules").append(...renderMarkdown(kit.house_rules));
  })
  .catch(() => {
    document.getElementById("skills").append(el("p", { class: "muted" }, "Could not load kit.json. Run the build to generate it."));
  });
