<script defer src="{relative_path}/assets/nodebb.min.js?{config.cache-buster}"></script>

{{{each scripts}}}
<script defer type="text/javascript" src="{scripts.src}"></script>
{{{end}}}

<script>

    document.body.addEventListener('mouseup', function(e) {
        const selectedText = window.getSelection().toString().trim();
        console.log("Selected text:", selectedText);
        if (selectedText && !selectedText.includes(" ")) {
            const response = fetchDefinition(selectedText);
            
            displayDefinition(response);
        }
    });

    // document.getElementById("close-btn").onclick = function() { }

    function fetchDefinition(word) {
        const url = `http://localhost:4567/api/dictionary/${word}`;

        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log("Definition:", data);
            })
            .catch(error => {
                console.error("Error fetching definition:", error);
            });
    }

    function displayDefinition(response) {
        const container = document.getElementById("dictionary")
        container.style.display = "inline";
        console.log(response);

        document.getElementById("word-header").textContent = "TEST"

        document.getElementById('play-pronounce').addEventListener('click', function() {
            const audio = new Audio("https://api.dictionaryapi.dev/media/pronunciations/en/test-us.mp3");
            audio.play();
        });


    }

    function hideDefinition() {
        document.getElementById("dictionary").style.display = "none"; 
        console.log("CLOSE");
    }


    

</script>