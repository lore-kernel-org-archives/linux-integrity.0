Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751864AbeCWA6F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 20:58:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2N0u9gW059881
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 20:58:05 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gvkmtqpt8-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 20:58:04 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 22 Mar 2018 18:58:04 -0600
Subject: Re: A subtle problem when resuming xen-front and using IMA and
 multiple TPM devices on the system
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <28f8dc8a-cfa3-376a-5e6a-98d79418e3d1@linux.vnet.ibm.com>
 <20180322213937.GF9469@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 20:57:59 -0400
MIME-Version: 1.0
In-Reply-To: <20180322213937.GF9469@ziepe.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0d302b6b-850f-9ae7-39e2-b28d859dbd38@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 03/22/2018 05:39 PM, Jason Gunthorpe wrote:
> On Thu, Mar 22, 2018 at 12:20:33PM -0400, Stefan Berger wrote:
>> I tried to convert the IMA code to look up a TPM chip and use it until
>> shutdown, when it releases it before device_shutdown(). Ideally this would
>> work but because of xen-front's resume code it doesn't. There the chip is
>> unregistered upon domU resume (tpmfront_resume calls tpmfron_remove) and for
>> that reason IMA cannot be holding onto that chip until shutdown.
> Well removing the TPM during resume seems totally wrong, don't do
> that.

though that's what seems to be happening:

static int tpmfront_remove(struct xenbus_device *dev)
{
     struct tpm_chip *chip = dev_get_drvdata(&dev->dev);
     struct tpm_private *priv = dev_get_drvdata(&chip->dev);
     tpm_chip_unregister(chip);                    <---- chip is gone 
upon resume
     ring_free(priv);
     dev_set_drvdata(&chip->dev, NULL);      <---- no additional 
get_device in this code; chip should be freed by now;
     return 0;
}

static int tpmfront_resume(struct xenbus_device *dev)
{
     /* A suspend/resume/migrate will interrupt a vTPM anyway */
     tpmfront_remove(dev);
     return tpmfront_probe(dev, NULL);
}






>
> Jason
>
