Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:23517 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCERlm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 12:41:42 -0500
Date: Mon, 5 Mar 2018 19:41:36 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm2-sessions: Add full HMAC and encrypt/decrypt
 session handling
Message-ID: <20180305174136.GA5791@linux.intel.com>
References: <1520057094.27452.16.camel@HansenPartnership.com>
 <1520057175.27452.18.camel@HansenPartnership.com>
 <20180305113533.GJ25377@linux.intel.com>
 <1520261912.5312.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1520261912.5312.3.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Mar 05, 2018 at 06:58:32AM -0800, James Bottomley wrote:
> On Mon, 2018-03-05 at 13:35 +0200, Jarkko Sakkinen wrote:
> > On Fri, Mar 02, 2018 at 10:06:15PM -0800, James Bottomley wrote:
> > > 
> > > diff --git a/drivers/char/tpm/tpm2b.h b/drivers/char/tpm/tpm2b.h
> > > new file mode 100644
> > > index 000000000000..c7726f2895aa
> > > --- /dev/null
> > > +++ b/drivers/char/tpm/tpm2b.h
> > > @@ -0,0 +1,82 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _TPM2_TPM2B_H
> > > +#define _TPM2_TPM2B_H
> > > +/*
> > > + * Handing for tpm2b structures to facilitate the building of
> > > commands
> > > + */
> > > +
> > > +#include "tpm.h"
> > > +
> > > +#include <asm/unaligned.h>
> > > +
> > > +struct tpm2b {
> > > +	struct tpm_buf buf;
> > > +};
> > > +
> > > +/* opaque structure, holds auth session parameters like the
> > > session key */
> > > +struct tpm2_auth;
> > > +
> > > +static inline int tpm2b_init(struct tpm2b *buf)
> > > +{
> > > +	return tpm_buf_init(&buf->buf, 0, 0);
> > > +}
> > > +
> > > +static inline void tpm2b_reset(struct tpm2b *buf)
> > > +{
> > > +	struct tpm_input_header *head;
> > > +
> > > +	head = (struct tpm_input_header *)buf->buf.data;
> > > +	head->length = cpu_to_be32(sizeof(*head));
> > > +}
> > > +
> > > +static inline void tpm2b_append(struct tpm2b *buf, const unsigned
> > > char *data,
> > > +				unsigned int len)
> > > +{
> > > +	tpm_buf_append(&buf->buf, data, len);
> > > +}
> > > +
> > > +#define TPM2B_APPEND(type) \
> > > +	static inline void tpm2b_append_##type(struct tpm2b *buf,
> > > const type value) { tpm_buf_append_##type(&buf->buf, value); }
> > > +
> > > +TPM2B_APPEND(u8)
> > > +TPM2B_APPEND(u16)
> > > +TPM2B_APPEND(u32)
> > > +
> > > +static inline void *tpm2b_buffer(const struct tpm2b *buf)
> > > +{
> > > +	return buf->buf.data + sizeof(struct tpm_input_header);
> > > +}
> > > +
> > > +static inline u16 tpm2b_len(struct tpm2b *buf)
> > > +{
> > > +	return tpm_buf_length(&buf->buf) - sizeof(struct
> > > tpm_input_header);
> > > +}
> > > +
> > > +static inline void tpm2b_destroy(struct tpm2b *buf)
> > > +{
> > > +	tpm_buf_destroy(&buf->buf);
> > > +}
> > > +
> > > +static inline void tpm_buf_append_2b(struct tpm_buf *buf, struct
> > > tpm2b *tpm2b)
> > > +{
> > > +	u16 len = tpm2b_len(tpm2b);
> > > +
> > > +	tpm_buf_append_u16(buf, len);
> > > +	tpm_buf_append(buf, tpm2b_buffer(tpm2b), len);
> > > +	/* clear the buf for reuse */
> > > +	tpm2b_reset(tpm2b);
> > > +}
> > > +
> > > +/* Macros for unmarshalling known size BE data */
> > > +#define GET_INC(type)					\
> > > +static inline u##type get_inc_##type(const u8 **ptr) {	\
> > > +	u##type val;					\
> > > +	val = get_unaligned_be##type(*ptr);		\
> > > +	*ptr += sizeof(val);				\
> > > +	return val;					\
> > > +}
> > > +
> > > +GET_INC(16)
> > > +GET_INC(32)
> > > +
> > > +#endif
> > > -- 
> > > 2.12.3
> > > 
> > 
> > Some meta stuff:
> > 
> > * Add me to TO-field because I should probably review and eventually
> >   test these, right?
> 
> Eventually; they're an RFC because we need to get the API right first
> (I've already got a couple of fixes to it).

For me the big picture looks good. You saw my comments about details.
Refine those and I think this would already be digestable change.

> > * CC to linux-security-module
> 
> There's no change to anything in security module, so why?  All security
> module people who care about the TPM should be on linux-integrity and
> those who don't likely don't want to see the changes.  The reason
> linux-crypto is on the cc is because I want them to make sure I'm using
> their crypto system correctly.

See:

https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity

The big changes that affect the whole security tree in direct or
indirect ways should go through that list. This was a wish from
James Morris.

> 
> > * Why there is no RFC tag given that these are so quite large
> > changes?
> 
> There is an RFC tag on 0/2

Ah, sorry, so it is.

> > * Why in hell tpm2b.h?
> 
> Because all sized TPM structures are in 2B form and manipulating them
> can be made a lot easier with helper routines.

I see it now that I looked the code in more detail.

Suggestions to move forward:

* Add enum tpm_buf_type { TPM_BUF_COMMAND, TPM_BUF_2B } and use
  struct tpm_buf for both.
* Move tpm_buf_* stuff from tpm.h and tpm2-cmd.c to tpm_buf_*.[ch].

I would even suggest to move current inline functions to tpm_buf.c
so that they can be traced. Performance impact is neglible but
tracing is an useful asset for testing.

For get_inc* I would just roll out two separate functions as the
redudancy is quite neglibe. I just want to keep things as simple
and trivial as possible.

> James

/Jarkko
