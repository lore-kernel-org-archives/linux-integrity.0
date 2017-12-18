Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37205 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759155AbdLRM3E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 07:29:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so28992512wmd.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 04:29:04 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Ettle <james@ettle.org.uk>, linux-integrity@vger.kernel.org,
        azhar.shaikh@intel.com, linux-kernel@vger.kernel.org,
        james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
Message-ID: <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
Date: Mon, 18 Dec 2017 13:29:01 +0100
MIME-Version: 1.0
In-Reply-To: <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/18/2017 01:22 PM, Javier Martinez Canillas wrote:

[snip]

> 
> James,
> 
> Can you please test the following (untested) patch on top of the other two
> mentioned patches to see if it makes a difference for you?
> 

I should had tried to at least compile the patch :)

Updated patch below:
