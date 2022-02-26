import React from "react";
import InputWithLabel from './search_form/input_with_label';

const SearchForm = ({
  searchTerm,
  onSearchInput,
  onSearchSubmit,
}) => (
  <form onSubmit={onSearchSubmit} className="search-form">
    <InputWithLabel
      id="search"
      value={searchTerm}
      isFocused
      onInputChange={onSearchInput}
    >
      <strong>Search:</strong>
    </InputWithLabel>

    <button
      type="submit"
      className="button button_large"
      disabled={!searchTerm}
    >
      Submit
    </button>
  </form>
);

export default SearchForm;