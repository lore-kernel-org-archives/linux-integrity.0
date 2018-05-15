Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751333AbeEOP6Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 May 2018 11:58:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4FFsrZb047682
        for <linux-integrity@vger.kernel.org>; Tue, 15 May 2018 11:58:23 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j00atgah6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 15 May 2018 11:58:23 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 15 May 2018 16:58:22 +0100
Subject: Re: [PATCH V3] evm: Allow non-SHA1 digital signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Tue, 15 May 2018 11:58:07 -0400
In-Reply-To: <20180514220730.99811-1-mjg59@google.com>
References: <20180514220730.99811-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526399887.3937.190.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-05-14 at 15:07 -0700, Matthew Garrett wrote:
> SHA1 is reasonable in HMAC constructs, but it's desirable to be able to
> use stronger hashes in digital signatures. Modify the EVM crypto code so
> the hash type is imported from the digital signature and passed down to
> the hash calculation code, and return the digest size to higher layers
> for validation.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Added a new struct type equivalent to ima_digest_data but with the
> digest field actually populated in order to make it practical to
> allocate on the stack, and reworked stuff to use that.
> 
>  security/integrity/evm/evm.h              |  5 +-
>  security/integrity/evm/evm_crypto.c       | 59 ++++++++++++-----------
>  security/integrity/evm/evm_main.c         | 20 +++++---
>  security/integrity/ima/ima_api.c          | 14 +++---
>  security/integrity/ima/ima_appraise.c     | 20 ++++----
>  security/integrity/ima/ima_crypto.c       | 28 +++++------
>  security/integrity/ima/ima_init.c         |  4 +-
>  security/integrity/ima/ima_template_lib.c | 12 ++---
>  security/integrity/integrity.h            | 11 ++++-
>  9 files changed, 96 insertions(+), 77 deletions(-)

Wow!  This is a lot more change than I expected.

> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 5e58e02ba8dc..6884b5e1c8a4 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -83,7 +83,7 @@ struct evm_ima_xattr_data {
> 
>  #define IMA_MAX_DIGEST_SIZE	64
> 
> -struct ima_digest_data {
> +struct ima_digest_header {
>  	u8 algo;
>  	u8 length;
>  	union {
> @@ -97,9 +97,18 @@ struct ima_digest_data {
>  		} ng;
>  		u8 data[2];
>  	} xattr;
> +} __packed;
> +
> +struct ima_digest_data {
> +	struct ima_digest_header header;
>  	u8 digest[0];
>  } __packed;
> 
> +struct ima_xattr {
> +	struct ima_digest_header header;
> +	u8 digest[IMA_MAX_DIGEST_SIZE];
> +} __packed;
> +

security.ima can be either a digest or a signature. Calling this
struct "ima_xattr" will be confusing.  The only thing common between
ima_digest_data and signature_v2_hdr is the first byte - the 'type'
field.

The IMA xattr is contained within this struct, but it is prefixed with
some additional info.  The original IMA xattr format starts with
ima_digest_header.xattr[1]; the IMA xattr-ng format starts with
ima_digest_header.xattr[0].  Even for security.ima containing digests,
naming this struct ima_xattr is confusing.

We need to calculate hashes based on hash algorithms with larger
digests, but at least for EVM we do not need to write them out as an
xattr.  There are a number of IMA examples where a struct, like below,
are defined.

struct {
     struct ima_digest_data hdr;
     char digest[IMA_MAX_DIGEST_SIZE];
} hash;

If a common struct was to be defined, I would appreciate separating
the IMA from the EVM changes.

Mimi
 
>  /*
>   * signature format v2 - for using with asymmetric keys
>   */
