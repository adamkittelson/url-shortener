import React from "react";
import CopyToClipboard from 'react-copy-to-clipboard';


const ShortUrlForm = ({
  longUrl,
  shortUrl,
  onCreateAnotherSubmit
}) => (
  <>
    <label htmlFor="long_url" className="label">
      🔗 Your long URL
    </label>
    <input
      id="long_url"
      value={longUrl}
      disabled
      className="input"
    />

    <label htmlFor="smol_url" className="label">
      🪄 SmolURL
    </label>

    <div className="row">
      <input
        id="smol_url"
        disabled={true}
        value={shortUrl}
        disabled
        className="input short"
      />

      <CopyToClipboard text={shortUrl}>
        <button>📋</button>
      </CopyToClipboard>
    </div>


    <button
      type="submit"
      className="button button_large"
      onClick={onCreateAnotherSubmit}
    >
      Shorten Another
    </button>
  </>
);

export default ShortUrlForm;