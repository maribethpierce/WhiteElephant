class PairMailer < ApplicationMailer
  def pair_mail(santa, recipient, group)
    @santa = santa
    @recipient = recipient
    @group = group
     mail(
       to: @santa.email,
       subject: "We drew names!"
     )
  end
end
