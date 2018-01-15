Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbeAORTP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 12:19:15 -0500
Date: Mon, 15 Jan 2018 09:19:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ima: define new policy condition based on the filesystem
 name
Message-ID: <20180115171914.GB28088@infradead.org>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
 <20180115162726.GB15686@infradead.org>
 <1516034407.6607.26.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1516034407.6607.26.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jan 15, 2018 at 11:40:07AM -0500, Mimi Zohar wrote:
> rootfs IS different than other filesystems, as other filesystems
> uniquely identify the underlying filesystem type.  rootfs can be a
> ramfs or tmpfs filesystem.  Only tmpfs supports xattrs.

Tons of filesystems only have xattrs optionally.  Check for goddamn
xattrs if that is the requirement and not a name that has absolutely
zero meaning for functionality.  That is the whole point!
