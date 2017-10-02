Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:56191 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdJBRCv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 13:02:51 -0400
Received: by mail-io0-f181.google.com with SMTP id z187so5289773ioz.12
        for <linux-integrity@vger.kernel.org>; Mon, 02 Oct 2017 10:02:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506823682.5691.173.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <20170927221653.11219-2-mjg59@google.com>
 <1506823682.5691.173.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 2 Oct 2017 10:02:50 -0700
Message-ID: <CACdnJuvzMKWNRSZy2LZUBv+qiPPDkm2ftNZ7RcdqbHXFP49bFg@mail.gmail.com>
Subject: Re: [PATCH 1/6] IMA: Allow EVM validation on appraisal even without a
 symmetric key
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 30, 2017 at 7:08 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Wed, 2017-09-27 at 15:16 -0700, Matthew Garrett wrote:
>> A reasonable configuration is to use IMA to appraise a subset of files
>> (based on user, security label or other features supported by IMA) but
>> to also want to use EVM to validate not only the state of the IMA hash
>> but also additional metadata on the file. Right now this is only
>> possible if a symmetric key has been loaded, which may not be desirable
>> in all cases (eg, one where EVM digital signatures are shipped to end
>> systems rather than EVM HMACs being generated locally).
>
> Commit 26ddabfe96bb "evm: enable EVM when X509 certificate is loaded"
> already allows EVM to be enabled without loading a symmetric key.

This only seems to be set if CONFIG_EVM_LOAD_X509 is set. Should there
be some sort of callback to set this if a key is loaded onto the evm
keyring at runtime?
