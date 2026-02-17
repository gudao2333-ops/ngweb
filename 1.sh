bash <(cat <<'EOF'
#!/bin/bash
set -e

if command -v apt >/dev/null 2>&1; then
    apt update -y
    apt install nginx -y
elif command -v yum >/dev/null 2>&1; then
    yum install epel-release -y
    yum install nginx -y
fi

systemctl enable nginx
systemctl start nginx

names=("NovaTech" "ApexCore" "VertexGlobal" "NexusWorks" "SkylineGroup" "OrbitSystems" "AtlasDigital" "FusionLabs" "QuantumEdge" "SummitTech")
industries=("Cloud Infrastructure" "Enterprise IT Solutions" "Cybersecurity Services" "Data Analytics" "Digital Transformation")

company="${names[$RANDOM % ${#names[@]}]}"
industry="${industries[$RANDOM % ${#industries[@]}]}"
year=$((2014 + RANDOM % 8))

mkdir -p /var/www/html/blog
mkdir -p /var/www/html/assets

cat > /var/www/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>$company</title>
<link rel="stylesheet" href="/assets/style.css">
</head>
<body>
<header>
<h1>$company</h1>
<nav>
<a href="/">Home</a>
<a href="/about.html">About</a>
<a href="/services.html">Services</a>
<a href="/blog.html">Insights</a>
<a href="/contact.html">Contact</a>
</nav>
</header>

<section>
<h2>Professional $industry</h2>
<p>Founded in $year, $company delivers scalable and secure $industry solutions for enterprises worldwide.</p>
</section>

<footer>
<p>© 2026 $company. All rights reserved.</p>
</footer>
</body>
</html>
HTML

cat > /var/www/html/about.html <<HTML
<h2>About $company</h2>
<p>$company was established in $year and focuses on providing reliable $industry services for global clients.</p>
HTML

cat > /var/www/html/services.html <<HTML
<h2>Our Services</h2>
<ul>
<li>$industry Consulting</li>
<li>Managed Infrastructure</li>
<li>Security & Compliance</li>
<li>Global Deployment Support</li>
</ul>
HTML

cat > /var/www/html/blog.html <<HTML
<h2>Insights</h2>
<ul>
<li><a href="/blog/post1.html">Trends in $industry</a></li>
<li><a href="/blog/post2.html">Building Resilient Systems</a></li>
<li><a href="/blog/post3.html">Future of Enterprise Technology</a></li>
</ul>
HTML

cat > /var/www/html/blog/post1.html <<HTML
<h2>Trends in $industry</h2>
<p>Modern enterprises are rapidly adopting scalable $industry frameworks to improve operational efficiency.</p>
HTML

cat > /var/www/html/blog/post2.html <<HTML
<h2>Building Resilient Systems</h2>
<p>Resilience and redundancy are key pillars of sustainable enterprise infrastructure.</p>
HTML

cat > /var/www/html/blog/post3.html <<HTML
<h2>Future of Enterprise Technology</h2>
<p>Digital transformation continues to reshape global industries through innovation and automation.</p>
HTML

cat > /var/www/html/contact.html <<HTML
<h2>Contact</h2>
<p>Email: contact@$company.com</p>
<p>Head Office: Singapore</p>
HTML

cat > /var/www/html/404.html <<HTML
<h2>404 - Page Not Found</h2>
<p>The page you are looking for does not exist.</p>
HTML

cat > /var/www/html/robots.txt <<TXT
User-agent: *
Allow: /
TXT

cat > /var/www/html/assets/style.css <<CSS
body {font-family: Arial, sans-serif; margin:0; background:#f4f6f9;}
header {background:#0b1f3a; color:white; padding:20px;}
nav a {color:white; margin-right:15px; text-decoration:none;}
section {padding:50px;}
footer {background:#0b1f3a; color:white; text-align:center; padding:15px;}
CSS

systemctl restart nginx

echo "=================================="
echo "Long-term enterprise site installed"
echo "Company: $company"
echo "Industry: $industry"
echo "=================================="
EOF
)
