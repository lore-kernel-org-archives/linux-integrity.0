Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37113 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966604AbeAORS3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 12:18:29 -0500
Date: Mon, 15 Jan 2018 09:18:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 0/2] turn on force option for FUSE in builtin policies
Message-ID: <20180115171825.GA28088@infradead.org>
References: <cover.1515682581.git.dongsu@kinvolk.io>
 <20180115144804.GA28856@infradead.org>
 <1516033961.6607.18.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1516033961.6607.18.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jan 15, 2018 at 11:32:41AM -0500, Mimi Zohar wrote:
> For XFS, which considers fsmagic numbers private to the filesystem,
> *always* using the fsmagic number is wrong.  As to whether this is
> true for other filesystems is unclear.  IMA policies have been defined
> in terms of fsmagic numbers for a long time.  fsmagic numbers were
> moved from the filesystems to magic.h for this purpose.  Someone would
> have complained earlier if it is always wrong.
>  
> I just posted a patch titled "ima: define new policy condition based
> on the filesystem name" to allow policies to be defined in terms of
> the i_sb->s_type->name.

ima has no business looking at either the name _or_ the magic number.
