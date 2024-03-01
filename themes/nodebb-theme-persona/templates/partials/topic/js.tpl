<script defer src="{relative_path}/assets/nodebb.min.js?{config.cache-buster}"></script>

{{{each scripts}}}
<script defer type="text/javascript" src="{scripts.src}"></script>
{{{end}}}

<script>

    let lastDisplayedWord = "";

    // add event listener for highlighting word
    document.body.addEventListener('mouseup', async function(e) {
        const selectedText = window.getSelection().toString().trim();

        // ensure only one word is selected
        if (selectedText && !selectedText.includes(" ")) {
            // don't resend request if selected word is already displayed
            if (selectedText === lastDisplayedWord && document.getElementById("dictionary").style.display == "inline") return;

            try {
                const response = await fetchDefinition(selectedText); 
                lastDisplayedWord = selectedText;
                displayDefinition(response);
            } catch (error) {
                console.error("Error processing definition:", error);
            }
        }
    });

    async function fetchDefinition(word) {
        const url = `https://shiny-telegram-g9jgw7rvvj6hp4jg-4567.app.github.dev/definition/` + word;
        try {
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            console.log("Definition:", data);
            return data;
        } catch (error) {
            console.error("Error fetching definition:", error);
            throw error;
        }
    }
   
    function displayDefinition(response) {
        const container = document.getElementById("dictionary");
        container.style.display = "inline";

        // response from API if a word has no definition
        if (response.title === 'No Definitions Found') {
            document.getElementById('play-pronounce').style.display = 'none'; // hide audio button
            document.getElementById("word-header").textContent = lastDisplayedWord; 
            const meaningsSpan = document.getElementById("meanings");
            meaningsSpan.textContent = "";

            const message = document.createElement("p");
            message.textContent = response.message;
            meaningsSpan.appendChild(message);

            message = document.createElement("p");
            message.textContent = response.resolution;
            meaningsSpan.appendChild(message);

            return;
        }

        const firstDef = response[0]; // only use the first set of definitions provided for brevity

        document.getElementById("word-header").textContent = firstDef.word;

        // check if pronounciation audio is included
        const audioSrc = firstDef.phonetics?.[1]?.audio;
        if (audioSrc) {
            document.getElementById('play-pronounce').style.display = 'inline';
            document.getElementById('play-pronounce').addEventListener('click', function() {
                const audio = new Audio(audioSrc);
                audio.play();
            });
        } else {
            document.getElementById('play-pronounce').style.display = 'none';
        }

        const meaningsSpan = document.getElementById("meanings");
        meaningsSpan.textContent = "";

        // only display the first two definitions at first
        firstDef.meanings.slice(0, 2).forEach((meaning, index) => {
            const partOfSpeechElement = document.createElement("h4");
            partOfSpeechElement.className = "partOfSpeech";
            partOfSpeechElement.textContent = meaning.partOfSpeech;
            meaningsSpan.appendChild(partOfSpeechElement);

            const definitionsList = document.createElement("ul");
            meaning.definitions.slice(0, 2).forEach(definition => {
                const definitionItem = document.createElement("li");
                definitionItem.textContent = definition.definition;
                definitionsList.appendChild(definitionItem);

                if (definition.synonyms && definition.synonyms.length > 0) {
                    const synonymsText = document.createElement("p");
                    synonymsText.innerHTML = "<b>Synonyms</b>: " + definition.synonyms.join(", ");
                    definitionsList.appendChild(synonymsText);
                }
                if (definition.antonyms && definition.antonyms.length > 0) {
                    const antonymsText = document.createElement("p");
                    antonymsText.innerHTML = "<b>Antonyms</b>: " + definition.antonyms.join(", ");
                    definitionsList.appendChild(antonymsText);
                }
            });
            meaningsSpan.appendChild(definitionsList);
        });

        // button to show additional meanings
        if (firstDef.meanings.length > 2) {
            const moreButton = document.createElement("button");
            moreButton.textContent = "...";
            moreButton.onclick = function() {
                this.remove();

                // same process as above for the rest of the json
                firstDef.meanings.slice(2).forEach(meaning => {
                    const partOfSpeechElement = document.createElement("h4");
                    partOfSpeechElement.className = "partOfSpeech";
                    partOfSpeechElement.textContent = meaning.partOfSpeech;
                    meaningsSpan.appendChild(partOfSpeechElement);

                    const definitionsList = document.createElement("ul");
                    meaning.definitions.forEach(definition => {
                        const definitionItem = document.createElement("li");
                        definitionItem.textContent = definition.definition;
                        definitionsList.appendChild(definitionItem);

                        if (definition.synonyms && definition.synonyms.length > 0) {
                            const synonymsText = document.createElement("p");
                            synonymsText.innerHTML = "<b>Synonyms</b>: " + definition.synonyms.join(", ");
                            definitionsList.appendChild(synonymsText);
                        }
                        if (definition.antonyms && definition.antonyms.length > 0) {
                            const antonymsText = document.createElement("p");
                            antonymsText.innerHTML = "<b>Antonyms</b>: " + definition.antonyms.join(", ");
                            definitionsList.appendChild(antonymsText);
                        }
                    });
                    meaningsSpan.appendChild(definitionsList);
                });
            };
            container.appendChild(moreButton);
        }
    } 

    function hideDefinition() {
        document.getElementById("dictionary").style.display = "none"; 
        console.log("CLOSE");
    }

</script>