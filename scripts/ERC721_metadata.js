const fs = require("fs");

const CID = "QmUAvFtsqW8XsBAJvaQEbFWybYKn9irVokrBJnnYPYB165";

// Turn "metadata to JSON"
for (let i = 0; i < 6; i++) {
    const filename = `${i}.json`;
    const data = {
        name: "NFT tutorial",
        description: "Icons NFT",
        image: `ipfs://${CID}/${i}.jpg`,
    };

    const jsonData = JSON.stringify(data, null, 2); // Formatear con espaciado para legibilidad

    // Asegúrate de que la carpeta ./metadata existe antes de escribir
    if (!fs.existsSync("./metadata")) {
        fs.mkdirSync("./metadata");
    }

    // Escribir el archivo
    fs.writeFile(`./metadata/${filename}`, jsonData, (err) => {
        if (err) {
            console.error(`Error al guardar ${filename}:`, err);
            throw err;
        }
        console.log(`${filename} ha sido guardado!`);
    });
}
