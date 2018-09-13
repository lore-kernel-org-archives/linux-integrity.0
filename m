Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:63447 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbeIMUbM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 16:31:12 -0400
Subject: Re: Question about the TPM driver
To: Javier Martinez Canillas <javierm@redhat.com>,
        Martin Galvan <omgalvan.86@gmail.com>,
        James.Bottomley@hansenpartnership.com
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <1536848529.3436.2.camel@HansenPartnership.com>
 <CAN19L9HHqs7WdxsS7zYLvQ1vbsDpViyMb+Xfz1bG3=c2Jz-Mbg@mail.gmail.com>
 <7e7a570b-b7d1-8a3f-6614-e301cbbf71ce@redhat.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <46c613d0-9da9-9f88-1711-43172ca946fe@intel.com>
Date: Thu, 13 Sep 2018 08:21:02 -0700
MIME-Version: 1.0
In-Reply-To: <7e7a570b-b7d1-8a3f-6614-e301cbbf71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 09/13/2018 08:11 AM, Javier Martinez Canillas wrote:
> There was an attempt to add partial reads support some time ago [0],
> but it was nacked due being an ABI break IIRC.
> 
> [0]: https://lkml.org/lkml/2018/7/19/618

I'm planning to give it another try, based on the feedback,
after the async patch is merged.
Thanks,
-- 
Tadeusz
