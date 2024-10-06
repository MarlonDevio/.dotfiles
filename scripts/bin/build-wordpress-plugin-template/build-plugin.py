#!/Users/marlon/.pyenv/shims/python3
import os
import re
from collections.abc import Callable
from pathlib import Path


def append_path(current_path: str) -> Callable:
    return lambda a: f"{current_path}/{a}"


def main():
    PLUGIN_NAME = get_plugin_name()
    VENDOR_NAME = get_vendor_name()
    ROOT_DIR = Path(PLUGIN_NAME)
    SRC_DIR = f"{PLUGIN_NAME}/src"

    # Frontend Directories
    FRONTEND_DIR = f"{SRC_DIR}/frontend"
    COMPONENTS_DIR = f"{FRONTEND_DIR}/components"
    PAGES_DIR = f"{FRONTEND_DIR}/pages"

    # Backend Directories
    BACKEND_DIR = f"{SRC_DIR}/backend"

    CONTROLLERS_DIR = f"{BACKEND_DIR}/Controllers"
    VIEWS_DIR = f"{BACKEND_DIR}/Views"
    MODELS_DIR = f"{BACKEND_DIR}/Models"

    PUBLIC_DIR = f"{SRC_DIR}/public"
    DIST_DIR = f"{PUBLIC_DIR}/dist"

    VENDOR_DIR = f"{ROOT_DIR}/vendor"

    directories_to_create = [
        ROOT_DIR,
        SRC_DIR,
        FRONTEND_DIR,
        COMPONENTS_DIR,
        PAGES_DIR,
        BACKEND_DIR,
        CONTROLLERS_DIR,
        VIEWS_DIR,
        MODELS_DIR,
        PUBLIC_DIR,
        DIST_DIR,
        VENDOR_DIR,
    ]

    for directory in directories_to_create:
        create_directory(directory)

    def generate_files(plugin_name, vendor_name, root_dir):
        # Paths to files
        COMPOSER_FILE = f"{root_dir}/composer.json"
        PACKAGE_JSON_FILE = f"{root_dir}/package.json"
        VITE_CONFIG_FILE = f"{root_dir}/vite.config.ts"
        ESLINT_CONFIG_FILE = f"{root_dir}/.eslintrc.js"
        PRETTIER_CONFIG_FILE = f"{root_dir}/.prettierrc"
        POSTCSS_CONFIG_FILE = f"{root_dir}/postcss.config.js"
        TAILWIND_CONFIG_FILE = f"{root_dir}/tailwind.config.js"
        TS_CONFIG_FILE = f"{root_dir}/tsconfig.json"
        INDEX_TS_FILE = f"{root_dir}/src/frontend/index.tsx"

        # Generate contents
        composer_content = generate_composer_json_content(
            plugin_name, vendor_name
        )
        package_json_content = generate_package_json_content(plugin_name)
        vite_config_content = generate_vite_config_content(plugin_name)
        eslint_config_content = generate_eslint_config_content()
        prettier_config_content = generate_prettier_config_content()
        postcss_config_content = generate_postcss_config_content()
        tailwind_config_content = generate_tailwind_config_content()
        ts_config_content = generate_tsconfig_content()

        # Write files
        write_to_file(COMPOSER_FILE, composer_content)
        write_to_file(PACKAGE_JSON_FILE, package_json_content)
        write_to_file(VITE_CONFIG_FILE, vite_config_content)
        write_to_file(ESLINT_CONFIG_FILE, eslint_config_content)
        write_to_file(PRETTIER_CONFIG_FILE, prettier_config_content)
        write_to_file(POSTCSS_CONFIG_FILE, postcss_config_content)
        write_to_file(TAILWIND_CONFIG_FILE, tailwind_config_content)
        write_to_file(TS_CONFIG_FILE, ts_config_content)
        write_to_file(INDEX_TS_FILE, ())

    # Generate files with dynamic content
    generate_files(PLUGIN_NAME, VENDOR_NAME, ROOT_DIR)


def generate_index_ts_content():
    index_ts_content = """import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(<App />, document.getElementById('root'));
"""
    return index_ts_content


def generate_tailwind_config_content():
    tailwind_content = """module.exports = {
  content: ["./src/frontend/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {},
  },
  plugins: [],
};
"""
    return tailwind_content


def generate_postcss_config_content():
    postcss_content = """module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
"""
    return postcss_content


def generate_tsconfig_content():
    tsconfig_content = """{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "jsx": "react-jsx",
    "moduleResolution": "Node",
    "esModuleInterop": true,
    "sourceMap": true,
    "strict": true,
    "baseUrl": "./src/frontend",
    "paths": {
      "@/*": ["*"]
    }
  },
  "include": ["src/frontend/**/*"],
  "exclude": ["node_modules", "public"]
}
"""
    return tsconfig_content


def generate_prettier_config_content():
    prettier_content = """{
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "singleQuote": true,
  "trailingComma": "es5",
  "jsxSingleQuote": false,
  "semi": true
}
"""
    return prettier_content


def generate_eslint_config_content():
    eslint_content = """module.exports = {
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: './tsconfig.json',
  },
  plugins: ['react', '@typescript-eslint'],
  extends: [
    'plugin:react/recommended',
    'plugin:@typescript-eslint/recommended',
    'prettier',
  ],
  rules: {
    // Add custom rules if needed
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
};
"""
    return eslint_content


def generate_package_json_content(plugin_name):
    package_content = f"""{{
  "name": "{plugin_name}",
  "version": "1.0.0",
  "description": "A WordPress plugin template with modern frontend tooling",
  "scripts": {{
    "dev": "vite",
    "build": "vite build",
    "lint": "eslint \\"src/frontend/**/*.{{
      js,jsx,ts,tsx}}\\"",
    "format": "prettier --write \\"src/frontend/**/*.{{
      js,jsx,ts,tsx,css}}\\""
  }},
  "dependencies": {{
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  }},
  "devDependencies": {{
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "autoprefixer": "^10.0.0",
    "eslint": "^8.0.0",
    "eslint-config-prettier": "^8.0.0",
    "eslint-plugin-react": "^7.0.0",
    "postcss": "^8.0.0",
    "prettier": "^2.0.0",
    "tailwindcss": "^3.0.0",
    "typescript": "^4.0.0",
    "vite": "^4.0.0",
    "@vitejs/plugin-react": "^3.0.0"
  }}
}}
"""
    return package_content


def generate_vite_config_content(plugin_name):
    vite_config_content = f"""import {{ defineConfig }} from 'vite';
import react from '@vitejs/plugin-react';
import * as path from 'path';

export default defineConfig({{
  plugins: [react()],
  root: 'src/frontend',
  base: '/wp-content/plugins/{plugin_name}/public/dist/',
  build: {{
    outDir: path.resolve(__dirname, 'public/dist'),
    emptyOutDir: true,
    manifest: true,
    rollupOptions: {{
      input: path.resolve(__dirname, 'src/frontend/index.tsx'),
    }},
  }},
  resolve: {{
    alias: {{
      '@': path.resolve(__dirname, 'src/frontend'),
    }},
  }},
}});
"""
    return vite_config_content


def generate_composer_json_content(plugin_name, vendor_name):
    namespace = (
        f"{vendor_name.capitalize()}\\\\{generate_camelcase_word(plugin_name)}"
    )
    composer_content = f"""{{
  "name": "{vendor_name}/{plugin_name}",
  "description": "A WordPress plugin template with modern tooling",
  "type": "wordpress-plugin",
  "license": "GPL-2.0-or-later",
  "require": {{
    "php": ">=7.4",
    "eftec/bladeone": "^4.7"
  }},
  "autoload": {{
    "psr-4": {{
      "{namespace}\\\\": "src/backend/"
    }}
  }}
}}
"""
    return composer_content


def get_vendor_name() -> str:
    generic_name = "vendor"
    vendor_name = input("Enter the name of the vendor: ")
    if not vendor_name:
        return generic_name
    return vendor_name


def get_plugin_name() -> str:
    generic_name = "new-plugin-project"
    plugin_name = input("Enter the name of the project: ")
    if not plugin_name:
        return generic_name
    return plugin_name


def create_directory(directory_name: Path) -> None:
    if not os.path.exists(directory_name):
        os.makedirs(directory_name)
    else:
        print(f"Directory '{directory_name}' already exists.")


def generate_camelcase_word(base_word: str):
    splitted_base_word = re.split(r"[-_ ]", base_word)
    return "".join([part[0].upper() for part in splitted_base_word])


def write_to_file(file_path: Path, content: str) -> None:
    with open(file_path, "w") as file:
        file.write(content)


main()
