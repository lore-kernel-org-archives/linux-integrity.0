Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19825 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755886AbeCVOFf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 10:05:35 -0400
Message-ID: <da6b99415c0f2c880eb80f700fbb321c33bda320.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: self test failure should not cause suspend to fail
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Daniel Drake <drake@endlessm.com>, peterhuewe@gmx.de
Cc: linux-integrity@vger.kernel.org, chiu@endlessm.com,
        linux@endlessm.com, jgg@ziepe.ca
Date: Thu, 22 Mar 2018 16:05:29 +0200
In-Reply-To: <9764f6e79dd7e8938eef9746eca88573f712efcb.camel@linux.intel.com>
References: <20180320073640.17062-1-drake@endlessm.com>
         <9764f6e79dd7e8938eef9746eca88573f712efcb.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-22 at 16:02 +0200, Jarkko Sakkinen wrote:
> On Tue, 2018-03-20 at 15:36 +0800, Daniel Drake wrote:
> > From: Chris Chiu <chiu@endlessm.com>
> > 
> > The Acer Acer Veriton X4110G has a TPM device detected as:
> >   tpm_tis 00:0b: 1.2 TPM (device-id 0xFE, rev-id 71)
> > 
> > After the first S3 suspend, the following error appears during resume:
> >   tpm tpm0: A TPM error(38) occured continue selftest
> > 
> > Any following S3 suspend attempts will now fail with this error:
> >   tpm tpm0: Error (38) sending savestate before suspend
> >   PM: Device 00:0b failed to suspend: error 38
> > 
> > Error 38 is TPM_ERR_INVALID_POSTINIT which means the TPM is
> > not in the correct state. This indicates that the platform BIOS
> > is not sending the usual TPM_Startup command during S3 resume.
> > From this point onwards, all TPM commands will fail.
> > 
> > The same issue was previously reported on Foxconn 6150BK8MC and
> > Sony Vaio TX3.
> > 
> > The platform behaviour seems broken here, but we should not break
> > suspend/resume because of this.
> > 
> > When the unexpected TPM state is encountered, set a flag to skip the
> > affected TPM_SaveState command on later suspends.
> > 
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> > Signed-off-by: Daniel Drake <drake@endlessm.com>
> > Link: http://lkml.kernel.org/r/CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64m
> > a2
> > 3UiQ@mail.gmail.com
> > Link: https://lkml.org/lkml/2011/3/28/192
> > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=591031
> 
> Thank you.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Applied. I also added:

Cc: stable@vger.kernel.org

/Jarkko
