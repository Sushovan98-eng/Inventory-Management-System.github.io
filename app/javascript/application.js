// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// My custom javascript
import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;

import Rails from "@rails/ujs";
Rails.start();
