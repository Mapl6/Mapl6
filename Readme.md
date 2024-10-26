<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tech Stack</title>
    <style>
        /* Container Styling */
        .tech-container {
            padding: 20px;
            color: #ffffff;
            border-radius: 8px;
            max-width: 900px;
            margin: auto;
            background-color: #1e1e1e;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            align-items: start;
        }
        /* Category Styling */
        .stack-category {
            text-align: center;
            background-color: #2e2e2e;
            padding: 20px;
            border-radius: 8px;
            transition: background 0.3s;
        }
        .stack-category h3 {
            font-size: 1.2rem;
            margin-bottom: 12px;
            color: #f2f2f2;
            border-bottom: 1px solid #555;
            display: inline-block;
            padding-bottom: 4px;
        }
        /* Icon Container */
        .tech-stack {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        /* Icon Styling with Hover */
        .tech-stack img {
            width: 45px;
            padding: 8px;
            background-color: #333;
            border-radius: 6px;
            transition: transform 0.3s, box-shadow 0.3s, background-color 0.3s;
        }
        .tech-stack img:hover {
            transform: scale(1.1);
            background-color: #555;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.4);
        }
    </style>
</head>
<body>
    <img src="./Mapl.png" alt="Mapl" width="1024" height="350"/>
    <div class="tech-container">
        <!-- Version Control -->
        <div class="stack-category">
            <h3>Version Control</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/192108372-f71d70ac-7ae6-4c0d-8395-51d8870c2ef0.png" alt="Git" title="Git">
                <img src="https://user-images.githubusercontent.com/25181517/192108374-8da61ba1-99ec-41d7-80b8-fb2f7c0a4948.png" alt="GitHub" title="GitHub">
            </div>
        </div>
        <!-- IDEs -->
        <div class="stack-category">
            <h3>IDEs</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/192108893-b1eed3c7-b2c4-4e1c-9e9f-c7e83637b33d.png" alt="WebStorm" title="WebStorm">
                <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/136815194/258326081-b113a23c-5c04-45aa-819c-bd04e8ac2a37.png" alt="Neovim" title="Neovim">
            </div>
        </div>
        <!-- Frontend Development -->
        <div class="stack-category">
            <h3>Frontend Development</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/192158954-f88b5814-d510-4564-b285-dff7d6400dad.png" alt="HTML" title="HTML">
                <img src="https://user-images.githubusercontent.com/25181517/183898674-75a4a1b1-f960-4ea9-abcb-637170a00a75.png" alt="CSS" title="CSS">
            </div>
        </div>
        <!-- UI/UX Design -->
        <div class="stack-category">
            <h3>UI/UX Design</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/189715289-df3ee512-6eca-463f-a0f4-c10d94a06b2f.png" alt="Figma" title="Figma">
            </div>
        </div>
        <div class="stack-category">
            <h3>UI Liberies</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/202896760-337261ed-ee92-4979-84c4-d4b829c7355d.png" alt="Tailwind CSS" title="Tailwind CSS">
                <img src="https://github.com/user-attachments/assets/9027732b-de8c-4c4b-a065-235e15e33e5e" alt="Next UI" title="Next UI">
            </div>
        </div>
        <!-- Programming Languages -->
        <div class="stack-category">
            <h3>Programming Languages</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/117447155-6a868a00-af3d-11eb-9cfe-245df15c9f3f.png" alt="JavaScript" title="JavaScript">
                <img src="https://user-images.githubusercontent.com/25181517/183890598-19a0ac2d-e88a-4005-a8df-1ee36782fde1.png" alt="TypeScript" title="TypeScript">
            </div>
        </div>
        <!-- Libraries & Frameworks -->
        <div class="stack-category">
            <h3>Libraries & Frameworks</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/183897015-94a058a6-b86e-4e42-a37f-bf92061753e5.png" alt="React" title="React">
                <img src="https://github.com/marwin1991/profile-technology-icons/assets/136815194/5f8c622c-c217-4649-b0a9-7e0ee24bd704" alt="Next.js" title="Next.js">
            </div>
        </div>
        <!-- Package Managers -->
        <div class="stack-category">
            <h3>Package Managers</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/121401671-49102800-c959-11eb-9f6f-74d49a5e1774.png" alt="npm" title="npm">
            </div>
        </div>
        <!-- Backend Development -->
        <div class="stack-category">
            <h3>Backend Development</h3>
            <div class="tech-stack">
                <img src="https://user-images.githubusercontent.com/25181517/183568594-85e280a7-0d7e-4d1a-9028-c8c2209e073c.png" alt="Node.js" title="Node.js">
            </div>
        </div>
    </div>
</body>
</html>