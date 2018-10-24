Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDCCC67863
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AF02082F
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdNcLppN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AF02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJXXeC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:34:02 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:46887 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJXXeC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 19:34:02 -0400
Received: by mail-lj1-f176.google.com with SMTP id x3-v6so5083592lji.13
        for <linux-integrity@vger.kernel.org>; Wed, 24 Oct 2018 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7MW2WN688enUwsXJ7O+5HppO8OQK6qJBRSdnea1qmwU=;
        b=FdNcLppN0JRLKLeWbPlkikS/G+qJAgIRa0abTKhamlxReFiAZqEPoWnqTLrGQ79mZi
         /fI8GNkOyyxLdSeYjP97Gz7cu2AC7QxG7TIUIanOX3txn55ZiWvpVGrzzfZH6N+r+HQP
         SxR2ks6ykjCI83gVHvm3NZVx5z96dAcurbFQkdF1eibtMQyx7iOZmljqZcpbjrpm1mkv
         t45easEn5RBA+dnoeO4FQFB9Voy5+3FyuDlu7ZnFYoqLlI1Ak1eHYUPCvAoLQmQtghSV
         tsVvvDtA74wkTnreFI5JeuW+DvJRiD3cO/ZfNpAsh+aihrCxnM7Dy+UnHFQ6jGZOwsLU
         Z5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7MW2WN688enUwsXJ7O+5HppO8OQK6qJBRSdnea1qmwU=;
        b=It8ODSnWG5ogzv8tdNx1iE8T3JJ9YFTGPZW6Sj+jlkIkYdfnPeqiNERdhRRKcN0YUu
         voJWEAk0uW6NcF0iNOgg69un/W+t1cXnCP+0N6/Z1rXgW8Vr5U7jqDm9dixyjfgtHVNd
         RHkrDTavT8MP8NqBjT9uPuq4NpwWJTi6ys5lK4Ls/nx8CCnaujbjs0V3JASy42WeW1m9
         ydncS/lLCLjRFU+bQ6q+8oHdHb0IBbfjPNOdh5NZ061L+hagbJN9HWMgtyD9wv7PLd5F
         O5g/+FU7t3KAQvraaS0CWMpepchfykP87sgEjNMV86DUZTR8crwLmfqhpX5DM7SBFKRA
         GhJA==
X-Gm-Message-State: AGRZ1gIAdVoazXq+GghySomPzy2yOsTh3bGXtkWAHCky2jKuQMtL6qvm
        aozb68jipo8Kg3hCDJU/paqxcxY3NiYYt+YwoTo=
X-Google-Smtp-Source: AJdET5fUgTfzxK56E2sUCli5J4CmNd0N44p9t1Lj3UIJGcHKFw58ryODHtPqrrxcZe/eAS3PO/oPmC8Fl+a/rviVD+4=
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr2007167ljd.129.1540393531347;
 Wed, 24 Oct 2018 08:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHw8A4VfDf9s9RsYKhc0-fp7=twepsG0t-cwZe-rYWHubF1SA@mail.gmail.com>
In-Reply-To: <CAMHw8A4VfDf9s9RsYKhc0-fp7=twepsG0t-cwZe-rYWHubF1SA@mail.gmail.com>
From:   Monty Wiseman <montywiseman32@gmail.com>
Date:   Wed, 24 Oct 2018 16:05:27 +0100
Message-ID: <CAMHw8A623QGkQ13ePpW0gxobzTEvsdyJdXjgfk1TavjQJ-6bBw@mail.gmail.com>
Subject: Re: Proposed change to tpm driver tpm_pcr_extend
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "David (GE Global Research, US)" <david.safford@ge.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adding Jarkko's real address.

On Wed, Oct 24, 2018 at 10:35 AM Monty Wiseman <montywiseman32@gmail.com> wrote:
>
> + Roberto, David
> Currently tpm_pcr_extend takes only 20 octets and "expands" if necessary
> to fill the size of other pcr banks. We want to make IMA algorithm agile.
>
> Current interface:
> int tpm_pcr_extend(struct tpm_chip *chip, int pcr-idx, const u8 *hash)
> {
> ...
> }
>
> Proposed:
> //Or should we use the defined constants from other libraries, for now
> // I'll use the TCG defined constants
> #define TPM_DIGEST_SIZE_SHA1   20
> #define TPM_DIGEST_SIZE_SHA256 32
> // Will need to define TCG algorithm IDs in TPM driver-specific header.
> // Alternatively we could use the IDs from IMA / Linux and make the driver
> // do the mapping to TCG alg IDs
> ...
>
> int tpm_pcr_extend(struct tpm_chip *chip, int pcr-idx, struct *pcr_bank_list)
> {
> // The driver will take the contents of the pcr_bank_list and create a
> // TPML_DIGEST_VALUES structure to pass into the TPM2_PCR_Extend command
>
> // See comment below about mismatched pcr banks
> }
>
> // The caller will allocate a static set of octet arrays, one for each allocated
> // pcr bank
> struct pcr_bank_list
> {
>         uint16 tcg_hash_algid; // this is from the TCG algorthm registry
>         uint8 hash_size; // size of octect array
>         uint8 *extend_array; // pointer to array of octets to Extend.
>         struct list_head pcr_bank;
> }
>
> // Caller allocates the following for each PCR bank. Each is pointed to by
> // parameter extend_array
> unit8[TPM_DIGEST_SIZE_SHA1] hash_sha1;
> unit8[TPM_DIGEST_SIZE_SHA256] hash_sha256;
> ....
>
> Mismatched PCR banks:
> There is no programatic method now to enforce a match between
> the caller's set of pcr banks and the TPM's allocated banks. For example,
> the caller might only be configured to produce SHA1 hashes but the
> platform owner (via a firmware setting) may have allocated PCR banks
> for SHA1 and SHA256
> Therefore, we propose the following as a starting point in the dicussion
>
> 1> If a PCR bank is allocated but there is no matching entry in the list of
> pcr_bank_list for the pcr allocated bank:
>       options:
>               A> Append 0's or truncate based on a set of pre-defined rules
>                   (See below)
>               B> Extend the missing pcr bank with a constant
>               C> Don't extend the missing bank.
>
> Option A:
> Append 0's or truncate in the following order
> TPM_ALG_SHA1 <-> TPM_ALG_SHA256 <-> TPM_ALG_SHA3_256 <-> TPM_ALG_SHA384 <->
> TPM_ALG_SHA3_384 <-> TPM_ALG_SHA512 <-> TPM_ALG_SHA3_512
>
> The question is what to do about TPM_ALG_SM3_256?
>
> Option C:
> This is a viable option and may actully be what the caller wants. There actually
> is no rule the all banks must be extended. In fact when "sealing", the
> caller lists
> the pcr banks they want to seal to. (While is it technically possible
> to provide the
> TPM2_PolicyPCR a mix of banks I don't beieve this practical as only
> one expected hash
> is provided as input. We should consider this option.
>
> Further, there is no TPM spec requirement to allocate banks for all
> PCRs. For example the
> following is allowed:
>
> PCR Allocated 1         2         3             4
> SHA1 bank     allocated allocated allocated     allocated
> SHA256 bank   allocated allocated Not allocated Not allocated
>
> Monty
