const fs = require('fs');
const path = require('path');
const { marked } = require('marked');

const DOCS = path.resolve(__dirname, '..', 'docs');

// Configure marked
marked.setOptions({
  breaks: true,
  gfm: true,
});

function getAllHtmlFiles(dir) {
  const files = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'assets' && entry.name !== 'node_modules') {
      files.push(...getAllHtmlFiles(fullPath));
    } else if (entry.isFile() && entry.name.endsWith('.html') && entry.name !== '404.html' && !(dir === DOCS && entry.name === 'index.html')) {
      files.push(fullPath);
    }
  }
  return files;
}

function hasDynamicLoading(html) {
  return html.includes('fetch(') && html.includes('marked.parse(') && html.includes('loading-spinner');
}

function getMdPath(htmlPath) {
  const dir = path.dirname(htmlPath);
  const basename = path.basename(htmlPath, '.html');
  return path.join(dir, basename + '.md');
}

function embedContent(html, mdHtml) {
  // Replace loading spinner with actual content
  html = html.replace(
    /<div id="article-content"[^>]*>[\s\S]*?<div class="loading-spinner">[^<]*<\/div>[\s\S]*?<\/div>/,
    `<div id="article-content" class="article-content">\n${mdHtml}\n      </div>`
  );

  // Remove the dynamic loading script block
  html = html.replace(
    /[\s]*\(function\(\) \{[\s\S]*?var mdPath = [\s\S]*?fetch\(mdPath\)[\s\S]*?}\)\(\);\n/,
    ''
  );

  return html;
}

function processFile(htmlPath) {
  const mdPath = getMdPath(htmlPath);
  if (!fs.existsSync(mdPath)) {
    console.log(`  SKIP: no .md file for ${path.relative(DOCS, htmlPath)}`);
    return false;
  }

  let html = fs.readFileSync(htmlPath, 'utf-8');
  if (!hasDynamicLoading(html)) {
    console.log(`  SKIP: already embedded ${path.relative(DOCS, htmlPath)}`);
    return false;
  }

  const md = fs.readFileSync(mdPath, 'utf-8');
  // Strip front matter (--- ... ---)
  const mdClean = md.replace(/^---[\s\S]*?---\n*/, '');
  const mdHtml = marked.parse(mdClean);

  const newHtml = embedContent(html, mdHtml);
  fs.writeFileSync(htmlPath, newHtml, 'utf-8');
  console.log(`  EMBEDDED ${path.relative(DOCS, htmlPath)}`);
  return true;
}

console.log('Embedding markdown content into HTML pages...\n');
const htmlFiles = getAllHtmlFiles(DOCS);
let count = 0;
let skip = 0;
for (const file of htmlFiles) {
  const result = processFile(file);
  if (result) count++;
  else skip++;
}
console.log(`\nDone. ${count} pages embedded, ${skip} skipped.`);
