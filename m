Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44991 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755896AbdLTSzE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 13:55:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id t8so11743689wmc.3
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 10:55:03 -0800 (PST)
Date: Wed, 20 Dec 2017 11:54:58 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
Message-ID: <20171220185458.GE22908@ziepe.ca>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com>
 <20171220180855.GB22908@ziepe.ca>
 <f9da193f-e1b4-c126-d272-b98bafda3b99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9da193f-e1b4-c126-d272-b98bafda3b99@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 07:21:31PM +0100, Javier Martinez Canillas wrote:

> > The below draft fixes everything except #1. That needs a more thoughtful
> > idea..
> >
> 
> I'll just drop this patch from the series and you can fix all the issues in
> the error / driver removal paths. It's not a dependency anyways, I included
> it just because noticed the issue while reading the code.

Azhar, this means it becomes your problem :)

Since the patches Jarkko has queued from you introduce oops's you need
to fix them..

Jason
