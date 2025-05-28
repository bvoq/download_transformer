# Download Transformer

**Download Transformer** is a simple asset transformer that fetches files over HTTPS at compile time. Ideal for managing large assets without checking them into source control or sharing assets with non-programmers.

## Installation

Add `download_transformer` to your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  download_transformer: ^1.0.0
```

## Usage

1. **Create an empty placeholder**

   In your assets folder, add an empty file named after the target asset, e.g., `texture_atlas.png`.

2. **Specify the download URL**

   Open the file and insert the asset URL on a single line, for example: `https://dekeyser.ch/texture_atlas.png`

3. **Configure the transformer**

   Reference the placeholder in your `pubspec.yaml` and attach the transformer:

   ```yaml
   flutter:
     assets:
       - path: assets/texture_atlas.png
         transformers:
           - package: download_transformer
   ```

4. **Build your project**

   During compilation, the transformer replaces the placeholder with the downloaded asset.

---

**That’s it!** No more checked-in binaries—just maintain URLs and let the build process fetch your assets automatically.
