import React from "react";

const UrlCreationForm = ({
  host,
  url,
  slug,
  onUrlInput,
  onSlugInput,
  onCreateUrlSubmit
}) => (
  <form onSubmit={onCreateUrlSubmit} className="url-creation-form">

    <label htmlFor="url" className="label">
      🔗 Input a long URL to make a SmolURL
    </label>
    <input
      id="url"
      value={url}
      onChange={onUrlInput}
      className="input"
    />

    <label htmlFor="url" className="label">
      🪄 Customize your link (optional)
    </label>
    <div className="row">
      <input
        disabled={true}
        value={host}
        className="input host"
        size={host.length - 4}
      />
      <input
        id="slug"
        className="input slug"
        value={slug}
        onChange={onSlugInput}
      />
    </div>

    <button
      type="submit"
      className="button button_large"
      disabled={!url}
    >
      Make SmolURL!
    </button>
  </form>
);

export default UrlCreationForm;