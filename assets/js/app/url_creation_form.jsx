import React from "react";
import InputWithLabel from './url_creation_form/input_with_label';

const UrlCreationForm = ({
  host,
  searchTerm,
  onSearchInput,
  onSearchSubmit,
}) => (
  <form onSubmit={onSearchSubmit} className="url-creation-form">

    <label htmlFor="url" className="label">
      🔗 Input a long URL to make a SmolURL
    </label>
    <input
      ref={React.useRef()}
      id="url"
      value={searchTerm}
      onChange={onSearchInput}
      className="input"
    />

    <label htmlFor="url" className="label">
      🪄 Customize your link
    </label>
    <div className="customize">
      <input
        disabled={true}
        value={`${host}/`}
        className="input host"
        size={host.length - 3}
      />
      <input
        ref={React.useRef()}
        className="input slug"
        value={searchTerm}
        onChange={onSearchInput}
      />
    </div>

    <button
      type="submit"
      className="button button_large"
      disabled={!searchTerm}
    >
      Make SmolURL!
    </button>
  </form>
);

export default UrlCreationForm;