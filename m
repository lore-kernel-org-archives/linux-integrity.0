Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36524 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbeFUTG0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 15:06:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so8074109wma.1
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jun 2018 12:06:25 -0700 (PDT)
Date: Thu, 21 Jun 2018 13:06:20 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621190620.GE19270@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
 <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
 <20180621175601.GC19270@ziepe.ca>
 <743f606f-b3eb-6917-33bb-5b080f76fe3f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <743f606f-b3eb-6917-33bb-5b080f76fe3f@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jun 21, 2018 at 02:19:44PM -0400, Stefan Berger wrote:
> On 06/21/2018 01:56 PM, Jason Gunthorpe wrote:
> >On Thu, Jun 21, 2018 at 01:45:03PM -0400, Stefan Berger wrote:
> >>On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
> >>>On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> >>>>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>>>get a reference to that chip. Once done with using the chip, the reference
> >>>>is released using tpm_chip_put().
> >>>>
> >>>>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>>You should sort this out in a way that we don't end up with duplicate
> >>>functions.
> >>Do you want me to create a function *like* tpm_chip_find_get() that takes an
> >>additional parameter whether to get the ops semaphore and have that function
> >>called by the existing tpm_chip_find_get() and the new tpm_chip_find(). The
> >>latter would then not get the ops semphore. I didn't want to do this since
> >>one time the function returns with a lock held and the other time not.
> >Another option, and I haven't looked, is to revise the callers of
> >tpm_chip_find_get to not require it to hold the ops semaphore for
> >them.
> 
> We have tpm_chip_unregister calling tpm_del_char_device to set the ops to
> NULL once a chip is unregistered. All existing callers, if they pass in a
> tpm_chip != NULL, currently fail if the ops are NULL. (If they pass in
> tpm_chip = NULL, they shouldn't find a chip once ops are null and it has
> been removed from the IDR). I wouldn't change that since IMA will call in
> with a tpm_chip != NULL and we want to protect the ops. All existing code
> within the tpm subsystem does seem to call tpm_chip_find_get() with a NULL
> pointer, though. Also trusted keys seems to pass in a NULL pointer every
> time.
> 
> >
> >Either by giving them an API to do it, or revising the TPM entry
> >points to do it.
> >
> >I didn't look, but how did the ops semaphore get grabbed in your
> >revised patches? They do grab it, right?
> 
> The revised patches do not touch the existing code much but will call
> tpm_chip_find_get() and get that semaphore every time before the ops are
> used. IMA is the only caller of tpm_chip_find() that now gets an additional
> reference to the tpm_chip and these APIs get called like this from IMA:
> 
> ima init: chip = tpm_chip_find()
> 
> ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
> 
> ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
> 
> [repeat]
> 
> ima shutdown: tpm_chip_put(chip)

Maybe just change tpm_chip_find_get() into tpm_get_ops(chip) and
convert all callers?

Jason
