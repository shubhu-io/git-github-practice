#!/bin/bash
# Webhook server for GitHub events

set -e

PORT=3000

# Simple webhook server using Node.js
cat > webhook-server.js << 'NODEJS'
const http = require('http');
const crypto = require('crypto');

const PORT = process.env.PORT || 3000;
const SECRET = process.env.WEBHOOK_SECRET || 'your-secret';

// Verify webhook signature
function verifySignature(req, body) {
    const signature = req.headers['x-hub-signature-256'];
    if (!signature) return false;
    
    const hmac = crypto.createHmac('sha256', SECRET);
    hmac.update(body);
    const expected = `sha256=${hmac.digest('hex')}`;
    
    return crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));
}

// Handle webhook events
function handleEvent(event, payload) {
    console.log(`\n--- ${event} ---`);
    
    switch (event) {
        case 'push':
            console.log(`Branch: ${payload.ref}`);
            console.log(`Commits: ${payload.commits.length}`);
            payload.commits.forEach(commit => {
                console.log(`  - ${commit.message}`);
            });
            break;
            
        case 'pull_request':
            console.log(`PR #${payload.pull_request.number}: ${payload.action}`);
            console.log(`Title: ${payload.pull_request.title}`);
            break;
            
        case 'issues':
            console.log(`Issue #${payload.issue.number}: ${payload.action}`);
            console.log(`Title: ${payload.issue.title}`);
            break;
            
        case 'release':
            console.log(`Release: ${payload.release.tag_name} ${payload.action}`);
            break;
            
        case 'workflow_run':
            console.log(`Workflow: ${payload.workflow_run.name} ${payload.workflow_run.conclusion}`);
            break;
            
        default:
            console.log(`Unhandled event: ${event}`);
            console.log(JSON.stringify(payload, null, 2));
    }
}

// Create server
const server = http.createServer((req, res) => {
    if (req.method === 'POST' && req.url === '/webhook') {
        let body = '';
        
        req.on('data', chunk => {
            body += chunk.toString();
        });
        
        req.on('end', () => {
            // Verify signature
            if (!verifySignature(req, body)) {
                console.error('Invalid signature');
                res.writeHead(401);
                res.end('Unauthorized');
                return;
            }
            
            // Parse and handle event
            const event = req.headers['x-github-event'];
            const payload = JSON.parse(body);
            
            handleEvent(event, payload);
            
            res.writeHead(200);
            res.end('OK');
        });
    } else {
        res.writeHead(404);
        res.end('Not Found');
    }
});

server.listen(PORT, () => {
    console.log(`Webhook server running on port ${PORT}`);
    console.log(`Endpoint: http://localhost:${PORT}/webhook`);
});
NODEJS

# Python version
cat > webhook-server.py << 'PYTHON'
#!/usr/bin/env python3
import http.server
import json
import hmac
import hashlib
import os

PORT = 3000
SECRET = os.environ.get('WEBHOOK_SECRET', 'your-secret').encode()

class WebhookHandler(http.server.BaseHTTPRequestHandler):
    def verify_signature(self, body):
        signature = self.headers.get('X-Hub-Signature-256', '')
        if not signature:
            return False
        
        expected = 'sha256=' + hmac.new(SECRET, body, hashlib.sha256).hexdigest()
        return hmac.compare_digest(signature, expected)
    
    def handle_event(self, event, payload):
        print(f"\n--- {event} ---")
        
        if event == 'push':
            print(f"Branch: {payload.get('ref')}")
            commits = payload.get('commits', [])
            print(f"Commits: {len(commits)}")
            for commit in commits:
                print(f"  - {commit.get('message')}")
        
        elif event == 'pull_request':
            pr = payload.get('pull_request', {})
            print(f"PR #{pr.get('number')}: {payload.get('action')}")
            print(f"Title: {pr.get('title')}")
        
        elif event == 'issues':
            issue = payload.get('issue', {})
            print(f"Issue #{issue.get('number')}: {payload.get('action')}")
            print(f"Title: {issue.get('title')}")
        
        else:
            print(f"Unhandled event: {event}")
            print(json.dumps(payload, indent=2))
    
    def do_POST(self):
        if self.path == '/webhook':
            content_length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(content_length)
            
            if not self.verify_signature(body):
                print("Invalid signature")
                self.send_response(401)
                self.end_headers()
                self.wfile.write(b'Unauthorized')
                return
            
            event = self.headers.get('X-GitHub-Event')
            payload = json.loads(body)
            
            self.handle_event(event, payload)
            
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b'OK')
        else:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b'Not Found')

if __name__ == '__main__':
    server = http.server.HTTPServer(('localhost', PORT), WebhookHandler)
    print(f"Webhook server running on port {PORT}")
    print(f"Endpoint: http://localhost:{PORT}/webhook")
    server.serve_forever()
PYTHON

# Bash version using netcat
cat > webhook-server.sh << 'BASH'
#!/bin/bash

PORT=3000

echo "Webhook server running on port $PORT"
echo "Endpoint: http://localhost:$PORT/webhook"

while true; do
    # Accept connection
    request=$(nc -l -p $PORT -q 1)
    
    # Parse request
    method=$(echo "$request" | head -1 | cut -d' ' -f1)
    path=$(echo "$request" | head -1 | cut -d' ' -f2)
    headers=$(echo "$request" | grep -v "^$" | head -n -1)
    body=$(echo "$request" | tail -n +$(($(echo "$request" | grep -n "^$" | head -1 | cut -d: -f1) + 1)))
    
    echo "--- Request ---"
    echo "Method: $method"
    echo "Path: $path"
    
    if [ "$method" = "POST" ] && [ "$path" = "/webhook" ]; then
        event=$(echo "$headers" | grep -i "x-github-event" | cut -d: -f2 | tr -d ' ')
        echo "Event: $event"
        echo "Body: $body"
    fi
done
BASH

echo "Webhook servers created:"
echo "1. webhook-server.js  - Node.js version"
echo "2. webhook-server.py  - Python version"
echo "3. webhook-server.sh  - Bash version"
echo ""
echo "To run:"
echo "  Node.js: node webhook-server.js"
echo "  Python:  python3 webhook-server.py"
echo "  Bash:    bash webhook-server.sh"
echo ""
echo "Set WEBHOOK_SECRET environment variable for signature verification"
