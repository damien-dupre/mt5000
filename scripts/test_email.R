################################################################################
#                              Email Test                                      #
################################################################################
gmail_dcu <- config::get("gmail_dcu")
# mailR ------------------------------------------------------------------------
library(mailR)
send.mail(
  from = gmail_dcu$email,
  to = gmail_dcu$email,
  subject = "test",
  body = "test",
  smtp = list(
    host.name = "smtp.gmail.com", port = 465,
    user.name = gmail_dcu$email,
    passwd = gmail_dcu$passwd,
    ssl = TRUE
  ),
  authenticate = TRUE,
  send = TRUE,
  html = TRUE
)

# blastula ---------------------------------------------------------------------
library(blastula)

# Get a nicely formatted date/time string
date_time <- add_readable_time()

# Create an image string using an on-disk
# image file
img_file_path <-
  system.file(
    "img", "pexels-photo-267151.jpeg",
    package = "blastula"
  )

img_string <- add_image(file = img_file_path)

email <-
  compose_email(
    body = md(
      c(
        "Hello,

This is a *great* picture I found when looking
for sun + cloud photos:
",
img_string
      )
    ),
footer = md(
  c(
    "Email sent on ", date_time, "."
  )
)
  )
email
# Sending email by SMTP using a credentials file
email %>%
  smtp_send(
    to = "damien.dupre@dcu.ie",
    from = "damien.dupre@dcu.ie",
    subject = "Testing the `smtp_send()` function",
    credentials = creds(
            provider = "gmail",
            user = "damien.dupre@dcu.ie")
  )

creds()
