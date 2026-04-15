import js from "@eslint/js";
import react from "eslint-plugin-react";
import reactHooks from "eslint-plugin-react-hooks";
import globals from "globals";

export default [
  js.configs.recommended,
  {
    files: ["app/frontend/**/*.{js,jsx}"],
    plugins: {
      react,
      "react-hooks": reactHooks,
    },
    languageOptions: {
      globals: {
        ...globals.browser,
      },
      parserOptions: {
        ecmaFeatures: { jsx: true },
      },
    },
    settings: {
      react: { version: "detect" },
    },
    rules: {
      ...react.configs.recommended.rules,
      ...reactHooks.configs.recommended.rules,
      "react/react-in-jsx-scope": "off",      // React 17+ JSX transform handles this
      "react/jsx-uses-react": "off",           // Pair with above — stops false "React unused" errors
      "react/prop-types": "off",               // Not using PropTypes
      "no-unused-vars": "error",               // Unused vars are always a mistake
      "no-console": "warn",                    // Warn during dev, clean up before committing
    },
  },
];
